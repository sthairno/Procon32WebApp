using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Procon32API.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Procon32API.Controllers
{
    /// <summary>
    /// 課題管理
    /// </summary>
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = "ApiKey")]
    public class SubmitController : ControllerBase
    {
        private readonly Procon32Context _context;

        public SubmitController(Procon32Context context)
        {
            _context = context;
        }

        /// <summary>
        /// 回答の検証
        /// </summary>
        /// <param name="body">回答データ</param>
        /// <param name="subjectId">課題ID</param>
        /// <returns>検証結果</returns>
        /// <response code="404">指定したIDの課題が見つからないとき</response>
        /// <response code="400">回答のフォーマットが不正な場合</response>
        /// <response code="200">回答が受理されたとき</response>
        [HttpPost]
        [Consumes("text/plain")]
        [Produces("text/plain")]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public async Task<ActionResult> Post([FromQuery][Required] string subjectId, [FromBody] string body)
        {
            var subject = await _context.Subject.FindAsync(subjectId);

            if (subject == null)
            {
                return NotFound($"Subject Not Found");
            }

            if (string.IsNullOrEmpty(body))
            {
                return BadRequest("ERROR");
            }

            Utilities.Answer answer;
            try
            {
                answer = Utilities.Answer.Parse(body);
            }
            catch (FormatException)
            {
                // 文法エラー

                return BadRequest("ERROR");
            }
            var checker = new Utilities.AnswerChecker(subject);

            var result = checker.Check(answer);

            return Ok($"ACCEPTED {result.InvalidPosPeaceCnt} {result.InvalidRotPeaceCnt}");
        }
    }
}
