using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Procon32API.Utilities
{
    public static class UniqueStringGenerator
    {
        public static string Generate() =>
            Convert.ToBase64String(Guid.NewGuid().ToByteArray()).Replace("=", "").Replace("+", "-").Replace("/", "_").Substring(0, 12);
    }
}
