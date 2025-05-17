using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class FixAttendanceRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "InstitutionId",
                table: "Attendances",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Attendances_InstitutionId",
                table: "Attendances",
                column: "InstitutionId");

            migrationBuilder.AddForeignKey(
                name: "FK_Attendances_Institutions_InstitutionId",
                table: "Attendances",
                column: "InstitutionId",
                principalTable: "Institutions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Attendances_Institutions_InstitutionId",
                table: "Attendances");

            migrationBuilder.DropIndex(
                name: "IX_Attendances_InstitutionId",
                table: "Attendances");

            migrationBuilder.DropColumn(
                name: "InstitutionId",
                table: "Attendances");
        }
    }
}
