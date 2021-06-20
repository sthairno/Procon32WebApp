using System.Linq;
using System.Security.Claims;
using System.Text.Encodings.Web;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Procon32API.Data;

namespace Procon32API
{
    class ApiKeyAuthHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        public static string GetUserID(HttpContext ctx) => ctx.User.Claims.FirstOrDefault(c => c.Type == "user_id").Value;

        private readonly Procon32Context _dbctx;

        public ApiKeyAuthHandler(IOptionsMonitor<AuthenticationSchemeOptions> options,
            ILoggerFactory logger,
            UrlEncoder encoder,
            ISystemClock clock,
            Procon32Context dbctx) : base(options, logger, encoder, clock)
        {
            _dbctx = dbctx;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Query.TryGetValue("key", out var key))
            {
                return AuthenticateResult.NoResult();
            }

            var apikey = await _dbctx.APIKey.FindAsync(key);
            if (apikey == null)
            {
                return AuthenticateResult.Fail("Invalid API Key");
            }

            var principal = new ClaimsPrincipal(new ClaimsIdentity(new[]
            {
                new Claim("user_id", apikey.UserID),
            }, "ApiKey"));

            return AuthenticateResult.Success(new AuthenticationTicket(
                principal,
                "ApiKey"
            ));
        }
    }
}