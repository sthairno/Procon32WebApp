using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Formatters;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace Procon32API.Utilities
{
    public class TextPlainInputFormatter : TextInputFormatter
    {
        public TextPlainInputFormatter()
        {
            SupportedMediaTypes.Add("text/plain");

            SupportedEncodings.Add(Encoding.UTF8);
            SupportedEncodings.Add(Encoding.Unicode);
        }

        protected override bool CanReadType(Type type)
        {
            return type == typeof(string);
        }

        public override async Task<InputFormatterResult> ReadRequestBodyAsync(InputFormatterContext context, Encoding encoding)
        {
            var httpContext = context.HttpContext;

            using var reader = new StreamReader(httpContext.Request.Body, encoding);

            try
            {
                string value = await reader.ReadToEndAsync();
                
                return await InputFormatterResult.SuccessAsync(value);
            }
            catch
            {
                return await InputFormatterResult.FailureAsync();
            }
        }
    }

    public class TextPlainOutputFormatter : TextOutputFormatter
    {
        public TextPlainOutputFormatter()
        {
            SupportedMediaTypes.Add("text/plain");

            SupportedEncodings.Add(Encoding.UTF8);
            SupportedEncodings.Add(Encoding.Unicode);
        }

        protected override bool CanWriteType(Type type)
        {
            return type == typeof(string);
        }

        public override async Task WriteResponseBodyAsync(OutputFormatterWriteContext context, Encoding selectedEncoding)
        {
            var httpContext = context.HttpContext;

            await httpContext.Response.WriteAsync(context.Object.ToString(), selectedEncoding);
        }
    }
}
