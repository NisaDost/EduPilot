using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class UpdatePublisherQuizRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "PublisherId",
                table: "Quizzes",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Quizzes_PublisherId",
                table: "Quizzes",
                column: "PublisherId");

            migrationBuilder.AddForeignKey(
                name: "FK_Quizzes_Publishers_PublisherId",
                table: "Quizzes",
                column: "PublisherId",
                principalTable: "Publishers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Quizzes_Publishers_PublisherId",
                table: "Quizzes");

            migrationBuilder.DropIndex(
                name: "IX_Quizzes_PublisherId",
                table: "Quizzes");

            migrationBuilder.DropColumn(
                name: "PublisherId",
                table: "Quizzes");
        }
    }
}
