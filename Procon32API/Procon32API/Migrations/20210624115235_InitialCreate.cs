using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace Procon32API.Migrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "APIKey",
                columns: table => new
                {
                    Key = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    UserID = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UpdatedDateTime = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_APIKey", x => x.Key);
                });

            migrationBuilder.CreateTable(
                name: "File",
                columns: table => new
                {
                    Path = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    MimeType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedUserId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedDateTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Size = table.Column<long>(type: "bigint", nullable: false),
                    Content = table.Column<byte[]>(type: "varbinary(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_File", x => x.Path);
                });

            migrationBuilder.CreateTable(
                name: "Image",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CreatedDateTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    CreatedUserId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Size_Width = table.Column<int>(type: "int", nullable: true),
                    Size_Height = table.Column<int>(type: "int", nullable: true),
                    RawFilePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ThumbnailFilePath = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Image", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "User",
                columns: table => new
                {
                    UserID = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    DisplayName = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    CreatedDateTime = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_User", x => x.UserID);
                });

            migrationBuilder.CreateTable(
                name: "Subject",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    CreatedUserId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CreatedDateTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Size_Width = table.Column<int>(type: "int", nullable: true),
                    Size_Height = table.Column<int>(type: "int", nullable: true),
                    SubjectFilePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    PreviewFilePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ThumbnailFilePath = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    BaseImageId = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(32)", maxLength: 32, nullable: false),
                    MaxSelectCount = table.Column<int>(type: "int", nullable: false),
                    SelectionCost = table.Column<int>(type: "int", nullable: false),
                    SwapCost = table.Column<int>(type: "int", nullable: false),
                    PeaceCount_X = table.Column<int>(type: "int", nullable: false),
                    PeaceCount_Y = table.Column<int>(type: "int", nullable: false),
                    Indexes = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Rotations = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Subject", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Subject_Image_BaseImageId",
                        column: x => x.BaseImageId,
                        principalTable: "Image",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Subject_BaseImageId",
                table: "Subject",
                column: "BaseImageId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "APIKey");

            migrationBuilder.DropTable(
                name: "File");

            migrationBuilder.DropTable(
                name: "Subject");

            migrationBuilder.DropTable(
                name: "User");

            migrationBuilder.DropTable(
                name: "Image");
        }
    }
}
