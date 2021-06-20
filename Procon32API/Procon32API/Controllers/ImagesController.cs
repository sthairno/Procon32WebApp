using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SixLabors.ImageSharp;
using Procon32API.Data;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using Procon32API.Utilities;
using Microsoft.AspNetCore.Authorization;

namespace Procon32API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = "ApiKey")]
    public class ImagesController : ControllerBase
    {
        private readonly Procon32Context _context;

        public ImagesController(Procon32Context context)
        {
            _context = context;
        }

        /// <summary>
        /// すべての画像を取得
        /// </summary>
        /// <returns>画像情報のリスト</returns>
        /// <response code="200">OK</response>
        [HttpGet]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<Models.Image>>> GetImage()
        {
            return await _context.Image.ToListAsync();
        }

        /// <summary>
        /// 画像情報の取得
        /// </summary>
        /// <param name="id">画像ID</param>
        /// <returns>画像情報</returns>
        /// <response code="200">OK</response>
        /// <response code="404">指定したIDの画像が見つからないとき</response>
        [HttpGet("{id}")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<Models.Image>> GetImage([FromRoute] string id)
        {
            var image = await _context.Image.FindAsync(id);

            if (image == null)
            {
                return NotFound();
            }

            return image;
        }

        /// <summary>
        /// 画像のアップロード
        /// </summary>
        /// <param name="file">画像ファイル</param>
        /// <returns>画像情報</returns>
        /// <response code="201">画像のアップロードが正常に完了したとき</response>
        /// <response code="400">画像ファイルの形式が不正であるとき</response>
        [HttpPost("upload")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<ActionResult<Models.Image>> PostImage(IFormFile file)
        {
            var userid = ApiKeyAuthHandler.GetUserID(HttpContext);

            if (file == null)
            {
                return BadRequest();
            }

            if (file.Length > 31457280L) // 30MB
            {
                return BadRequest("File Too Large");
            }

            var image = new Models.Image()
            {
                Id = UniqueStringGenerator.Generate(),
                CreatedDateTime = DateTime.Now,
                CreatedUserId = userid
            };

            // ファイルのダウンロード
            var filePath = Path.GetTempFileName();
            try
            {
                using (var stream = System.IO.File.Create(filePath))
                {
                    await file.CopyToAsync(stream);

                    // 画像読み込み

                    stream.Position = 0;

                    try
                    {
                        using (Image<Rgb24> rawImg = Image.Load<Rgb24>(stream))
                        {
                            Size rawImgSize = rawImg.Size();

                            image.Size = new() { Width = rawImgSize.Width, Height = rawImgSize.Height };

                            // 画像サイズチェック
                            if (rawImgSize.Width < 32 || 2048 < rawImgSize.Width ||
                               rawImgSize.Height < 32 || 2048 < rawImgSize.Height)
                            {
                                return BadRequest("Invalid Image Size");
                            }

                            // 元画像保存

                            image.RawFilePath = await Utilities.DbFileHelper.SaveAsync(
                                _context,
                                $"image/{image.Id}.png",
                                "image/png",
                                userid,
                                async (stream) => await rawImg.SaveAsPngAsync(stream));

                            // サムネイル画像作成

                            Utilities.ThumbnailImageGenerator.Convert(rawImg, 480 * 360);

                            image.ThumbnailFilePath = await Utilities.DbFileHelper.SaveAsync(
                                _context,
                                $"image/{image.Id}_thumb.jpg",
                                "image/jpeg",
                                userid,
                                async (stream) => await rawImg.SaveAsJpegAsync(stream));
                        }
                    }
                    catch (ImageFormatException ex)
                    {
                        if (ex is UnknownImageFormatException ||
                            ex is InvalidImageContentException)
                        {
                            // サポートしていないファイル形式

                            return BadRequest("Not Supported File Format");
                        }
                        throw;
                    }
                }
            }
            finally
            {
                System.IO.File.Delete(filePath);
            }

            // データベース追加
            _context.Image.Add(image);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetImage", new { id = image.Id }, image);
        }

        /// <summary>
        /// 画像の削除
        /// </summary>
        /// <param name="id">画像ID</param>
        /// <response code="204">画像が正常に削除できたとき</response>
        /// <response code="404">指定したIDの画像が見つからないとき</response>
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteImage([FromRoute] string id)
        {
            var userid = ApiKeyAuthHandler.GetUserID(HttpContext);

            var image = await _context.Image.FindAsync(id);
            if (image == null)
            {
                return NotFound();
            }

            if(image.CreatedUserId != userid)
            {
                return Forbid();
            }

            _context.Image.Remove(image);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
