using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.IO;

namespace Procon32API.Models
{
    public class User
    {
        /// <summary>
        /// ユーザー固有のID
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// ユーザー指定の表示名
        /// </summary>
        [Required]
        [RegularExpression(@"^[^\p{C}\s][^\p{C}\f\n\r\t\v]*[^\p{C}\s]$")]
        [StringLength(maximumLength: 50, MinimumLength = 3)]
        public string DisplayName { get; set; }

        /// <summary>
        /// ユーザーの作成日
        /// </summary>
        public DateTime CreatedDateTime { get; set; }
    }

    public class APIKey
    {
        [Key]
        public string Key { get; set; }

        public string UserID { get; set; }

        public DateTime UpdatedDateTime { get; set; }
    }
}