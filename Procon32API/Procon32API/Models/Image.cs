using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace Procon32API.Models
{
    [Owned]
    public class Size
    {
        public int Width { get; set; }

        public int Height { get; set; }
    }

    public class Image
    {
        [Key]
        public string Id { get; set; }

        public DateTime CreatedDateTime { get; set; }

        public string CreatedUserId { get; set; }

        public Size Size { get; set; }

        public string RawFilePath { get; set; }

        public string ThumbnailFilePath { get; set; }
    }
}
