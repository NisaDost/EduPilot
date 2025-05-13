using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class FixNamingInStudentsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "MugShot",
                table: "Students",
                newName: "Mugshot");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Mugshot",
                table: "Students",
                newName: "MugShot");
        }
    }
}
