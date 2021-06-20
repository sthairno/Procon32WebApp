using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Procon32API.Data;

namespace Procon32API.Utilities
{
    public static class DbFileHelper
    {
        public const string BaseUrl = "/files";

        public static readonly Regex PathRegex = new(@"^\/?(\w{2,16}\/)*\w{1,64}\.[a-z]{3,4}$", RegexOptions.Compiled);

        public static async Task<string> SaveAsync(Procon32Context dbcontext, string reqPath, string type, string createdUserId, Func<MemoryStream, Task> writer)
        {
            if (!PathRegex.IsMatch(reqPath))
            {
                throw new ArgumentException("パスの形式が正しくありません", "reqPath");
            }

            string fullPath = $"{BaseUrl}{(reqPath.StartsWith('/') ? "" : "/")}{reqPath}";

            using var stream = new MemoryStream();

            await writer(stream);

            var content = stream.ToArray();

            var file = new Models.File()
            {
                Path = fullPath,
                MimeType = type,
                CreatedDateTime = DateTime.Now,
                CreatedUserId = createdUserId,
                Size = content.Length,
                Content = content,
            };

            dbcontext.File.Add(file);
            await dbcontext.SaveChangesAsync();

            return fullPath;
        }

        public static async Task LoadAsync(Procon32Context dbcontext, string fullPath, Func<MemoryStream, Task> reader)
        {
            if (!PathRegex.IsMatch(fullPath))
            {
                throw new FileNotFoundException();
            }

            var file = await dbcontext.File.FindAsync(fullPath);
            if (file is null)
            {
                throw new FileNotFoundException();
            }

            using var stream = new MemoryStream(file.Content);

            await reader(stream);
        }

        public static async Task DeleteAsync(Procon32Context dbcontext, string fullPath)
        {
            var file = await dbcontext.File.FindAsync(fullPath);
            if (file == null)
            {
                return;
            }

            dbcontext.File.Remove(file);
        }
    }
}
