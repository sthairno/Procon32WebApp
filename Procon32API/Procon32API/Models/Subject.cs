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
    /// ピース回転情報
    /// </summary>
    public enum PeaceRotate
    {
        /// <summary>
        /// 0度回転
        /// </summary>
        Rotate0 = 0,

        /// <summary>
        /// 90度回転
        /// </summary>
        Rotate90 = 90,

        /// <summary>
        /// 180度回転
        /// </summary>
        Rotate180 = 180,

        /// <summary>
        /// 270度回転
        /// </summary>
        Rotate270 = 270
    }

    [Owned]
    public class CountXY
    {
        /// <summary>
        /// X方向の個数
        /// </summary>
        [Required]
        [Range(2, 16)]
        public int X { get; set; }

        /// <summary>
        /// Y方向の個数
        /// </summary>
        [Required]
        [Range(2, 16)]
        public int Y { get; set; }
    }

    /// <summary>
    /// 課題情報
    /// </summary>
    public class Subject
    {
        /// <summary>
        /// 課題ID
        /// </summary>
        [Key]
        public string Id { get; set; }

        /// <summary>
        /// 作成者ユーザーID
        /// </summary>
        public string CreatedUserId { get; set; }

        /// <summary>
        /// 作成日
        /// </summary>
        public DateTime CreatedDateTime { get; set; }

        /// <summary>
        /// 画像サイズ
        /// </summary>
        public Size Size { get; set; }

        /// <summary>
        /// 課題ファイルパス
        /// </summary>
        public string SubjectFilePath { get; set; }

        /// <summary>
        /// プレビュー画像パス
        /// </summary>
        public string PreviewFilePath { get; set; }

        /// <summary>
        /// サムネイル画像パス
        /// </summary>
        public string ThumbnailFilePath { get; set; }

        [BindNever]
        [ForeignKey("BaseImageId")]
        public Image BaseImage { get; set; }

        /// <summary>
        /// 原画像ID
        /// </summary>
        [Required]
        public string BaseImageId { get; set; }

        /// <summary>
        /// 表示名
        /// </summary>
        [RegularExpression(@"^[^\p{C}\s]+$")]
        [Required]
        [StringLength(maximumLength: 32, MinimumLength = 3)]
        public string Name { get; set; }

        /// <summary>
        /// 最大選択回数
        /// </summary>
        [Required]
        [Range(2, 128)]
        public int MaxSelectCount { get; set; }

        /// <summary>
        /// 選択コスト
        /// </summary>
        [Required]
        [Range(1, 500)]
        public int SelectionCost { get; set; }

        /// <summary>
        /// 交換コスト
        /// </summary>
        [Required]
        [Range(1, 100)]
        public int SwapCost { get; set; }

        /// <summary>
        /// ピースの個数
        /// </summary>
        [Required]
        public CountXY PeaceCount { get; set; }

        [Required]
        public string[][] Indexes { get; set; }

        [Required]
        public PeaceRotate[][] Rotations { get; set; }
    }
}
