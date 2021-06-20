using SixLabors.ImageSharp;
using SixLabors.ImageSharp.PixelFormats;
using SixLabors.ImageSharp.Processing;
using System;

namespace Procon32API.Utilities
{
    public static class ThumbnailImageGenerator
    {
        public static Image<Rgb24> Generate(Image<Rgb24> image, long thumbMaxPixels)
        {
            var clone = image.Clone();

            Convert(clone, thumbMaxPixels);

            return clone;
        }

        public static void Convert(Image<Rgb24> image, long thumbMaxPixels)
        {
            Size imgSize = image.Size();
            long imgPixels = imgSize.Width * imgSize.Height;

            if (imgPixels > thumbMaxPixels)
            {
                double per = Math.Sqrt((double)thumbMaxPixels / imgPixels);
                Size thumbImgSize = new(
                    (int)(imgSize.Width * per),
                    (int)(imgSize.Height * per));

                image.Mutate(c =>
                {
                    c.Resize(thumbImgSize);
                });
            }
        }
    }
}
