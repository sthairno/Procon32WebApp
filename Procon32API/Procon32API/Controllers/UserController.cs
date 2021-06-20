using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Procon32API.Data;
using Procon32API.Models;

namespace Procon32API
{
    /// <summary>
    /// ユーザー管理
    /// </summary>
    [Route("[controller]")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class UserController : ControllerBase
    {
        private readonly Procon32Context _context;

        private string GetFirebaseUID() => HttpContext.User.Claims.FirstOrDefault(c => c.Type == "user_id").Value;

        public UserController(Procon32Context context)
        {
            _context = context;
        }

        /// <summary>
        /// ユーザーを登録
        /// </summary>
        /// <returns>ユーザー情報</returns>
        [HttpPost]
        [Consumes("application/json")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status201Created)]
        public async Task<ActionResult<User>> RegisterUser([FromBody] User user)
        {
            var id = GetFirebaseUID();

            if (await _context.User.FindAsync(id) != null)
            {
                return Conflict("User Already Created");
            }

            user.UserID = id;
            user.CreatedDateTime = DateTime.Now;

            await _context.User.AddAsync(user);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetUser", user);
        }

        /// <summary>
        /// ユーザーを削除
        /// </summary>
        [HttpDelete]
        [Consumes("application/json")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> DeleteUser()
        {
            var id = GetFirebaseUID();
            var user = await _context.User.FindAsync(id);

            if (user == null)
            {
                return NotFound();
            }

            _context.User.Remove(user);

            var apikey = await _context.APIKey.FirstOrDefaultAsync(key => key.UserID == id);
            if (apikey != null)
            {
                _context.APIKey.Remove(apikey);
            }

            await _context.SaveChangesAsync();

            // TODO: ユーザーが作成したデータの消去処理

            return NoContent();
        }

        /// <summary>
        /// 自身のユーザー情報を取得
        /// </summary>
        /// <returns>ユーザー情報</returns>
        [HttpGet]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<User>> GetUser()
        {
            var id = GetFirebaseUID();
            var user = await _context.User.FindAsync(id);

            if (user == null)
            {
                return NotFound("User Not Found");
            }

            return Ok(user);
        }

        /// <summary>
        /// APIキーの取得
        /// </summary>
        /// <returns>APIキー</returns>
        [HttpGet("apikey")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<APIKey>> GetApiKey()
        {
            var id = GetFirebaseUID();
            var user = await _context.User.FindAsync(id);

            if (user == null)
            {
                return NotFound("User Not Found");
            }

            var apikey = await _context.APIKey.FirstOrDefaultAsync(key => key.UserID == id);
            if (apikey == null)
            {
                return NotFound("APIKey Not Created");
            }

            return Ok(new { apikey = apikey.Key });
        }

        /// <summary>
        /// APIキーの更新
        /// </summary>
        /// <returns>APIキー</returns>
        [HttpPost("apikey/update")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<ActionResult<APIKey>> UpdateApiKey()
        {
            var id = GetFirebaseUID();
            var user = await _context.User.FindAsync(id);

            if (user == null)
            {
                return NotFound("User Not Found");
            }

            var oldApikey = await _context.APIKey.FirstOrDefaultAsync(key => key.UserID == id);
            if (oldApikey != null)
            {
                _context.APIKey.Remove(oldApikey);
            }

            var newApikey = new APIKey()
            {
                Key = Guid.NewGuid().ToString("N"),
                UserID = id,
                UpdatedDateTime = DateTime.Now
            };
            await _context.APIKey.AddAsync(newApikey);

            await _context.SaveChangesAsync();

            return Ok(newApikey);
        }

        /// <summary>
        /// ユーザー情報の取得
        /// </summary>
        /// <param name="id">ユーザーID</param>
        /// <returns>ユーザー情報</returns>
        [HttpGet("{id}")]
        [Produces("application/json")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [AllowAnonymous]
        public async Task<ActionResult<User>> GetUserById(string id)
        {
            var user = await _context.User.FindAsync(id);

            if (user == null)
            {
                return NotFound();
            }

            return Ok(user);
        }

    }
}
