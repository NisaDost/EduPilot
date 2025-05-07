using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class UpdateSimulationTableNames : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_StudentSimulation_Simulation_SimulationId",
                table: "StudentSimulation");

            migrationBuilder.DropForeignKey(
                name: "FK_StudentSimulation_Students_StudentId",
                table: "StudentSimulation");

            migrationBuilder.DropPrimaryKey(
                name: "PK_StudentSimulation",
                table: "StudentSimulation");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Simulation",
                table: "Simulation");

            migrationBuilder.RenameTable(
                name: "StudentSimulation",
                newName: "StudentSimulations");

            migrationBuilder.RenameTable(
                name: "Simulation",
                newName: "Simulations");

            migrationBuilder.RenameIndex(
                name: "IX_StudentSimulation_StudentId",
                table: "StudentSimulations",
                newName: "IX_StudentSimulations_StudentId");

            migrationBuilder.RenameIndex(
                name: "IX_StudentSimulation_SimulationId",
                table: "StudentSimulations",
                newName: "IX_StudentSimulations_SimulationId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_StudentSimulations",
                table: "StudentSimulations",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Simulations",
                table: "Simulations",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_StudentSimulations_Simulations_SimulationId",
                table: "StudentSimulations",
                column: "SimulationId",
                principalTable: "Simulations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_StudentSimulations_Students_StudentId",
                table: "StudentSimulations",
                column: "StudentId",
                principalTable: "Students",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_StudentSimulations_Simulations_SimulationId",
                table: "StudentSimulations");

            migrationBuilder.DropForeignKey(
                name: "FK_StudentSimulations_Students_StudentId",
                table: "StudentSimulations");

            migrationBuilder.DropPrimaryKey(
                name: "PK_StudentSimulations",
                table: "StudentSimulations");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Simulations",
                table: "Simulations");

            migrationBuilder.RenameTable(
                name: "StudentSimulations",
                newName: "StudentSimulation");

            migrationBuilder.RenameTable(
                name: "Simulations",
                newName: "Simulation");

            migrationBuilder.RenameIndex(
                name: "IX_StudentSimulations_StudentId",
                table: "StudentSimulation",
                newName: "IX_StudentSimulation_StudentId");

            migrationBuilder.RenameIndex(
                name: "IX_StudentSimulations_SimulationId",
                table: "StudentSimulation",
                newName: "IX_StudentSimulation_SimulationId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_StudentSimulation",
                table: "StudentSimulation",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Simulation",
                table: "Simulation",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_StudentSimulation_Simulation_SimulationId",
                table: "StudentSimulation",
                column: "SimulationId",
                principalTable: "Simulation",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_StudentSimulation_Students_StudentId",
                table: "StudentSimulation",
                column: "StudentId",
                principalTable: "Students",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
