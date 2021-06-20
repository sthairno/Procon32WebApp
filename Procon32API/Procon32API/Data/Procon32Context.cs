using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Procon32API.Models;

namespace Procon32API.Data
{
    public class Procon32Context : DbContext
    {
        public Procon32Context(DbContextOptions<Procon32Context> options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder
                .Entity<Subject>()
                .Property(e => e.Indexes)
                .HasConversion(
                    v => JsonConvert.SerializeObject(v, Formatting.None),
                    v => JsonConvert.DeserializeObject<string[][]>(v));

            modelBuilder
                .Entity<Subject>()
                .Property(e => e.Rotations)
                .HasConversion(
                    v => JsonConvert.SerializeObject(v, Formatting.None),
                    v => JsonConvert.DeserializeObject<PeaceRotate[][]>(v));
        }

        public DbSet<Subject> Subject { get; set; }

        public DbSet<Image> Image { get; set; }

        public DbSet<File> File { get; set; }

        public DbSet<User> User { get; set; }

        public DbSet<APIKey> APIKey { get; set; }
    }
}
