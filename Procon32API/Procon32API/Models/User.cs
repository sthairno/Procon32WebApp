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
    /// <summary>
    /// ユーザーデータ
    /// </summary>
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

    /// <summary>
    /// APIキー
    /// </summary>
    public class APIKey
    {
        /// <summary>
        /// APIキーの値
        /// </summary>
        [Key]
        public string Key { get; set; }

        /// <summary>
        /// APIキーに関連付けられたユーザーID
        /// </summary>
        public string UserID { get; set; }

        /// <summary>
        /// 更新日
        /// </summary>
        public DateTime UpdatedDateTime { get; set; }
    }
}