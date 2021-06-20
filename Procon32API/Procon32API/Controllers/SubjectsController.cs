using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Procon32API.Data;
using Microsoft.AspNetCore.Authorization;
using Procon32API.Utilities;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using SixLabors.ImageSharp;
using System.Globalization;
using System.IO;
using System.Text;
using System.Runtime.InteropServices;
using Microsoft.AspNetCore.Http;

namespace Procon32API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = "ApiKey")]
    public class SubjectsController : ControllerBase
    {
        private readonly Procon32Context _context;

        public SubjectsController(Procon32Context context)
        {
            _context = context;
        }

        /// <summary>
        /// すべての課題を取得
        /// </summary>
        /// <returns>課題情報のリスト</returns>
        /// <response code="200">OK</response>
        [HttpGet]
        [AllowAnonymous]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult<IEnumerable<Models.Subject>>> GetSubject()
        {
            return await _context.Subject.ToListAsync();
        }

        /// <summary>
        /// 課題情報の取得
        /// </summary>
        /// <param name="id">課題ID</param>
        /// <returns>課題情報</returns>
        /// <response code="200">OK</response>
        /// <response code="404">指定したIDの課題が見つからないとき</response>
        [HttpGet("{id}")]
        [AllowAnonymous]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<Models.Subject>> GetSubject([FromRoute] string id)
        {
            var subject = await _context.Subject.FindAsync(id);

            if (subject == null)
            {
                return NotFound();
            }

            return subject;
        }

        /// <summary>
        /// 課題の生成
        /// </summary>
        /// <param name="subject">課題情報</param>
        /// <returns>課題情報</returns>
        /// <response code="201">課題の生成が正常に完了したとき</response>
        /// <response code="404">指定したIDの原画像が見つからないとき</response>
        [HttpPost]
        [Consumes("application/json")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<Models.Subject>> PostSubject([FromBody] Models.Subject subject)
        {
            var userid = ApiKeyAuthHandler.GetUserID(HttpContext);

            subject.Id = UniqueStringGenerator.Generate();

            subject.BaseImage = await _context.Image.FindAsync(subject.BaseImageId);
            if (subject.BaseImage == null)
            {
                return NotFound();
            }

            // 課題ファイル&プレビュー画像の生成
            try
            {
                int peaceCnt = subject.PeaceCount.X * subject.PeaceCount.Y;

                var peaceImages = new Image<Rgb24>[peaceCnt]; //base
                var peaceOrder = subject.Indexes //subj->base
                    .SelectMany(row => row.Select(str =>
                    {
                        int x = int.Parse($"{str[0]}", NumberStyles.HexNumber);
                        int y = int.Parse($"{str[1]}", NumberStyles.HexNumber);

                        return subject.PeaceCount.X * y + x;
                    }))
                    .ToArray();
                var peaceRotate = subject.Rotations //subj
                    .SelectMany(row => row.Select(rot =>
                    {
                        switch (rot)
                        {
                            case Models.PeaceRotate.Rotate0:
                                return RotateMode.None;
                            case Models.PeaceRotate.Rotate90:
                                return RotateMode.Rotate90;
                            case Models.PeaceRotate.Rotate180:
                                return RotateMode.Rotate180;
                            case Models.PeaceRotate.Rotate270:
                                return RotateMode.Rotate270;
                        }
                        return RotateMode.None;
                    }))
                    .ToArray();

                int peaceSize = 0;
                Size subjectSize = new(0, 0);

                // 原画像読み込み
                await DbFileHelper.LoadAsync(
                    _context,
                    subject.BaseImage.RawFilePath,
                    async (stream) =>
                    {
                        using (Image<Rgb24> baseImg = await Image.LoadAsync<Rgb24>(stream))
                        {
                            var baseSize = baseImg.Size();

                            peaceSize = Math.Min(baseSize.Width / subject.PeaceCount.X, baseSize.Height / subject.PeaceCount.Y);

                            subjectSize = new Size(subject.PeaceCount.X, subject.PeaceCount.Y) * peaceSize;
                            subject.Size = new() { Width = subjectSize.Width, Height = subjectSize.Height };

                            // 原画像を分割

                            int baseIdx = 0;
                            for (int y = 0; y < subject.PeaceCount.Y; y++)
                            {
                                for (int x = 0; x < subject.PeaceCount.X; x++)
                                {
                                    Rectangle cropRect = new(x * peaceSize, y * peaceSize, peaceSize, peaceSize);
                                    int subjIdx = Array.IndexOf(peaceOrder, baseIdx);

                                    Image<Rgb24> peaceImg = baseImg.Clone();

                                    peaceImg.Mutate(c => c.Crop(cropRect).Rotate(peaceRotate[subjIdx]));
                                    peaceImages[baseIdx] = peaceImg;

                                    baseIdx++;
                                }
                            }
                        }
                    });

                // 課題画像生成
                subject.SubjectFilePath = await DbFileHelper.SaveAsync(
                    _context,
                    $"subject/{subject.Id}.ppm",
                    "image/x-portable-pixmap",
                    userid,
                    async (stream) =>
                    {
                        using (var subjectFileWriter = new StreamWriter(stream, Encoding.UTF8))
                        using (Image<Rgb24> subjectImg = new Image<Rgb24>(subjectSize.Width, subjectSize.Height))
                        {
                            subjectFileWriter.NewLine = "\n";

                            // 分割画像を結合
                            int subjIdx = 0;
                            for (int y = 0; y < subject.PeaceCount.Y; y++)
                            {
                                for (int x = 0; x < subject.PeaceCount.X; x++)
                                {
                                    Point drawPos = new(x * peaceSize, y * peaceSize);
                                    subjectImg.Mutate(c => c.DrawImage(peaceImages[peaceOrder[subjIdx++]], drawPos, 1f));
                                }
                            }

                            // PPMファイルの書き込み

                            // ヘッダ書き込み
                            subjectFileWriter.WriteLine($"P6");
                            subjectFileWriter.WriteLine($"# {subject.PeaceCount.X} {subject.PeaceCount.Y}");
                            subjectFileWriter.WriteLine($"# {subject.MaxSelectCount}");
                            subjectFileWriter.WriteLine($"# {subject.SelectionCost} {subject.SwapCost}");
                            subjectFileWriter.WriteLine($"{subjectSize.Width} {subjectSize.Height}");
                            subjectFileWriter.WriteLine($"255");
                            subjectFileWriter.Flush();

                            // 課題画像書き込み
                            await Task.Run(() =>
                            {
                                for (int y = 0; y < subjectImg.Height; y++)
                                {
                                    Span<Rgb24> pixelRowSpan = subjectImg.GetPixelRowSpan(y);

                                    byte[] buff = new byte[subjectImg.Width * 3];
                                    unsafe
                                    {
                                        fixed (Rgb24* first = &pixelRowSpan.ToArray()[0])
                                        {
                                            Marshal.Copy((IntPtr)first, buff, 0, buff.Length);
                                        }
                                    }
                                    subjectFileWriter.BaseStream.Write(buff);
                                }
                            });

                            // プレビュー画像書き込み

                            subject.PreviewFilePath = await DbFileHelper.SaveAsync(_context,
                                $"subject/{subject.Id}.png",
                                "image/png",
                                userid,
                                async (stream) => await subjectImg.SaveAsPngAsync(stream));

                            // サムネイル画像作成

                            ThumbnailImageGenerator.Convert(subjectImg, 480 * 360);

                            subject.ThumbnailFilePath = await DbFileHelper.SaveAsync(_context,
                                $"subject/{subject.Id}_thumb.jpg",
                                "image/jpeg",
                                userid,
                                async (stream) => await subjectImg.SaveAsJpegAsync(stream));
                        }
                    });
            }
            catch
            {
                await Utilities.DbFileHelper.DeleteAsync(_context, subject.ThumbnailFilePath);
                await Utilities.DbFileHelper.DeleteAsync(_context, subject.PreviewFilePath);
                await Utilities.DbFileHelper.DeleteAsync(_context, subject.SubjectFilePath);
                throw;
            }

            subject.CreatedUserId = userid;

            _context.Subject.Add(subject);

            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSubject", new { id = subject.Id }, subject);
        }

        /// <summary>
        /// 課題の削除
        /// </summary>
        /// <param name="id">課題ID</param>
        /// <response code="204">課題が正常に削除できたとき</response>
        /// <response code="404">指定したIDの課題が見つからないとき</response>
        [HttpDelete("{id}")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteSubject([FromRoute] string id)
        {
            var userid = ApiKeyAuthHandler.GetUserID(HttpContext);

            var subject = await _context.Subject.FindAsync(id);
            if (subject == null)
            {
                return NotFound();
            }

            if(subject.CreatedUserId != userid)
            {
                return Forbid();
            }

            _context.Subject.Remove(subject);
            await _context.SaveChangesAsync();

            await Utilities.DbFileHelper.DeleteAsync(_context, subject.ThumbnailFilePath);
            await Utilities.DbFileHelper.DeleteAsync(_context, subject.PreviewFilePath);
            await Utilities.DbFileHelper.DeleteAsync(_context, subject.SubjectFilePath);

            return NoContent();
        }

        private bool ImageExists(string id)
        {
            return _context.Image.Any(e => e.Id == id);
        }
    }
}
