using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddSolvedQuizInfoTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "SolvedQuizInfos",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    StudentId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    QuizId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Difficulty = table.Column<int>(type: "int", nullable: false),
                    TrueCount = table.Column<int>(type: "int", nullable: false),
                    FalseCount = table.Column<int>(type: "int", nullable: false),
                    EmptyCount = table.Column<int>(type: "int", nullable: false),
                    TotalQuestionCount = table.Column<int>(type: "int", nullable: false),
                    SolvedDate = table.Column<DateTime>(type: "date", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SolvedQuizInfos", x => x.Id);
                    table.ForeignKey(
                        name: "FK_SolvedQuizInfos_Quizzes_QuizId",
                        column: x => x.QuizId,
                        principalTable: "Quizzes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_SolvedQuizInfos_Students_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Students",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_SolvedQuizInfos_QuizId",
                table: "SolvedQuizInfos",
                column: "QuizId");

            migrationBuilder.CreateIndex(
                name: "IX_SolvedQuizInfos_StudentId",
                table: "SolvedQuizInfos",
                column: "StudentId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "SolvedQuizInfos");
        }
    }
}
