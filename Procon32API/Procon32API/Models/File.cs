using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Procon32API.Models
{
    public class File
    {
        [Key]
        public string Path { get; set; }

        public string MimeType { get; set; }

        public string CreatedUserId { get; set; }

        public DateTime CreatedDateTime { get; set; }

        public long Size { get; set; }

        public byte[] Content { get; set; }
    }
}
