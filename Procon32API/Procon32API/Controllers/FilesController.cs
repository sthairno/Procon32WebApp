using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Procon32API.Data;
using Procon32API.Models;
using Procon32API.Utilities;

namespace Procon32API
{
    [Route(DbFileHelper.BaseUrl)]
    public class FilesController : ControllerBase
    {
        private readonly Procon32Context _context;

        public FilesController(Procon32Context context)
        {
            _context = context;
        }

        // GET: files/(dir/)*file.exp
        [HttpGet(@"{**name:length(1,64)}")]
        public async Task<ActionResult> GetFile(string name)
        {
            if(!DbFileHelper.PathRegex.IsMatch(name))
            {
                return NotFound();
            }

            string path = $"{DbFileHelper.BaseUrl}/{name}";

            var file = await _context.File.FindAsync(path);

            if (file == null)
            {
                return NotFound();
            }

            return File(file.Content, file.MimeType);
        }
    }
}
