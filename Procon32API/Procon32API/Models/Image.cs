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
    /// <summary>
    /// サイズ情報
    /// </summary>
    [Owned]
    public class Size
    {
        /// <summary>
        /// 横幅
        /// </summary>
        public int Width { get; set; }

        /// <summary>
        /// 縦幅
        /// </summary>
        public int Height { get; set; }
    }
    
    /// <summary>
    /// 画像情報
    /// </summary>
    public class Image
    {
        /// <summary>
        /// 画像ID
        /// </summary>
        [Key]
        public string Id { get; set; }

        /// <summary>
        /// 作成日
        /// </summary>
        public DateTime CreatedDateTime { get; set; }

        /// <summary>
        /// 作成者ユーザー
        /// </summary>
        public string CreatedUserId { get; set; }

        /// <summary>
        /// 画像サイズ
        /// </summary>
        public Size Size { get; set; }

        /// <summary>
        /// 画像ファイルパス
        /// </summary>
        public string RawFilePath { get; set; }

        /// <summary>
        /// サムネイル画像パス
        /// </summary>
        public string ThumbnailFilePath { get; set; }
    }
}
