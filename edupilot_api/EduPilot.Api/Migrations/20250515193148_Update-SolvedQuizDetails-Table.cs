using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSolvedQuizDetailsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Choices_SelectedChoiceId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Questions_QuestionId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Quizzes_QuizId",
                table: "SolvedQuizDetails");

            migrationBuilder.AddColumn<DateOnly>(
                name: "Date",
                table: "WeakSubjects",
                type: "date",
                nullable: false,
                defaultValue: new DateOnly(1, 1, 1));

            migrationBuilder.AlterColumn<Guid>(
                name: "SelectedChoiceId",
                table: "SolvedQuizDetails",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"),
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier",
                oldNullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "StudentId",
                table: "SolvedQuizDetails",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_SolvedQuizDetails_StudentId",
                table: "SolvedQuizDetails",
                column: "StudentId");

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Choices_SelectedChoiceId",
                table: "SolvedQuizDetails",
                column: "SelectedChoiceId",
                principalTable: "Choices",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Questions_QuestionId",
                table: "SolvedQuizDetails",
                column: "QuestionId",
                principalTable: "Questions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Quizzes_QuizId",
                table: "SolvedQuizDetails",
                column: "QuizId",
                principalTable: "Quizzes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Students_StudentId",
                table: "SolvedQuizDetails",
                column: "StudentId",
                principalTable: "Students",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Choices_SelectedChoiceId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Questions_QuestionId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Quizzes_QuizId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropForeignKey(
                name: "FK_SolvedQuizDetails_Students_StudentId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropIndex(
                name: "IX_SolvedQuizDetails_StudentId",
                table: "SolvedQuizDetails");

            migrationBuilder.DropColumn(
                name: "Date",
                table: "WeakSubjects");

            migrationBuilder.DropColumn(
                name: "StudentId",
                table: "SolvedQuizDetails");

            migrationBuilder.AlterColumn<Guid>(
                name: "SelectedChoiceId",
                table: "SolvedQuizDetails",
                type: "uniqueidentifier",
                nullable: true,
                oldClrType: typeof(Guid),
                oldType: "uniqueidentifier");

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Choices_SelectedChoiceId",
                table: "SolvedQuizDetails",
                column: "SelectedChoiceId",
                principalTable: "Choices",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Questions_QuestionId",
                table: "SolvedQuizDetails",
                column: "QuestionId",
                principalTable: "Questions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_SolvedQuizDetails_Quizzes_QuizId",
                table: "SolvedQuizDetails",
                column: "QuizId",
                principalTable: "Quizzes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
