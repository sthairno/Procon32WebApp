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
using Procon32API.Utilities;

namespace Procon32API
{
    [Route("api/[controller]")]
    public class PingController : ControllerBase
    {
        public PingController()
        {

        }

        [HttpGet]
        public IActionResult Ping()
        {
            return Ok(new { Status = "OK" });
        }

        [HttpGet("jwt")]
        [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
        public IActionResult PingWithJWTAuth()
        {
            var userID = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "user_id").Value;
            return Ok(new { Status = "OK", UserID = userID });
        }

        [HttpGet("apikey")]
        [Authorize(AuthenticationSchemes = "ApiKey")]
        public IActionResult PingWithApiKeyAuth()
        {
            var userID = HttpContext.User.Claims.FirstOrDefault(c => c.Type == "user_id").Value;
            return Ok(new { Status = "OK", UserID = userID });
        }
    }
}
