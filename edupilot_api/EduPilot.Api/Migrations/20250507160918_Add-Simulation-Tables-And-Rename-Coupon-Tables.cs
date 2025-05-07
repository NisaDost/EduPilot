using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace EduPilot.Api.Migrations
{
    /// <inheritdoc />
    public partial class AddSimulationTablesAndRenameCouponTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClaimedCoupon_Coupon_CouponId",
                table: "ClaimedCoupon");

            migrationBuilder.DropForeignKey(
                name: "FK_ClaimedCoupon_Students_StudentId",
                table: "ClaimedCoupon");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Coupon",
                table: "Coupon");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ClaimedCoupon",
                table: "ClaimedCoupon");

            migrationBuilder.RenameTable(
                name: "Coupon",
                newName: "Coupons");

            migrationBuilder.RenameTable(
                name: "ClaimedCoupon",
                newName: "ClaimedCoupons");

            migrationBuilder.RenameIndex(
                name: "IX_ClaimedCoupon_StudentId",
                table: "ClaimedCoupons",
                newName: "IX_ClaimedCoupons_StudentId");

            migrationBuilder.RenameIndex(
                name: "IX_ClaimedCoupon_CouponId",
                table: "ClaimedCoupons",
                newName: "IX_ClaimedCoupons_CouponId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Coupons",
                table: "Coupons",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ClaimedCoupons",
                table: "ClaimedCoupons",
                column: "Id");

            migrationBuilder.CreateTable(
                name: "Simulation",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(250)", maxLength: 250, nullable: false),
                    StudyDuration = table.Column<int>(type: "int", nullable: false, defaultValue: 0),
                    BreakDuration = table.Column<int>(type: "int", nullable: false, defaultValue: 0)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Simulation", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "StudentSimulation",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    StudentId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    SimulationId = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    StudiedAt = table.Column<DateTime>(type: "datetime2", nullable: false, defaultValueSql: "GETDATE()")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StudentSimulation", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StudentSimulation_Simulation_SimulationId",
                        column: x => x.SimulationId,
                        principalTable: "Simulation",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_StudentSimulation_Students_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Students",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_StudentSimulation_SimulationId",
                table: "StudentSimulation",
                column: "SimulationId");

            migrationBuilder.CreateIndex(
                name: "IX_StudentSimulation_StudentId",
                table: "StudentSimulation",
                column: "StudentId");

            migrationBuilder.AddForeignKey(
                name: "FK_ClaimedCoupons_Coupons_CouponId",
                table: "ClaimedCoupons",
                column: "CouponId",
                principalTable: "Coupons",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ClaimedCoupons_Students_StudentId",
                table: "ClaimedCoupons",
                column: "StudentId",
                principalTable: "Students",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ClaimedCoupons_Coupons_CouponId",
                table: "ClaimedCoupons");

            migrationBuilder.DropForeignKey(
                name: "FK_ClaimedCoupons_Students_StudentId",
                table: "ClaimedCoupons");

            migrationBuilder.DropTable(
                name: "StudentSimulation");

            migrationBuilder.DropTable(
                name: "Simulation");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Coupons",
                table: "Coupons");

            migrationBuilder.DropPrimaryKey(
                name: "PK_ClaimedCoupons",
                table: "ClaimedCoupons");

            migrationBuilder.RenameTable(
                name: "Coupons",
                newName: "Coupon");

            migrationBuilder.RenameTable(
                name: "ClaimedCoupons",
                newName: "ClaimedCoupon");

            migrationBuilder.RenameIndex(
                name: "IX_ClaimedCoupons_StudentId",
                table: "ClaimedCoupon",
                newName: "IX_ClaimedCoupon_StudentId");

            migrationBuilder.RenameIndex(
                name: "IX_ClaimedCoupons_CouponId",
                table: "ClaimedCoupon",
                newName: "IX_ClaimedCoupon_CouponId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Coupon",
                table: "Coupon",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_ClaimedCoupon",
                table: "ClaimedCoupon",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_ClaimedCoupon_Coupon_CouponId",
                table: "ClaimedCoupon",
                column: "CouponId",
                principalTable: "Coupon",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ClaimedCoupon_Students_StudentId",
                table: "ClaimedCoupon",
                column: "StudentId",
                principalTable: "Students",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
