using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/coupon")]
    [ApiController]
    [Authorize]
    public class CouponsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public CouponsController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet("active")]
        public async Task<ActionResult<List<CouponDTO>>> GetActiveCoupons()
        {
            var coupons = await _context.Coupons
                .Where(c => c.IsAvailable)
                .Select(c => new CouponDTO()
                {
                    Id = c.Id,
                    Name = c.Name,
                    Description = c.Description,
                    Icon = c.Icon,
                    Fee = c.Fee
                })
                .ToListAsync();

            if (coupons == null)
            {
                return NotFound("No active coupons found.");
            }
            return coupons;
        }

        [HttpPost("{id}/student/{studentId}")]
        public async Task<ActionResult<ClaimedCoupon>> PostClaimCoupon(Guid id, Guid studentId)
        {
            var coupon = await _context.Coupons.FindAsync(id);
            if (coupon == null)
            {
                return NotFound("Coupon not found.");
            }

            var student = await _context.Students.FindAsync(studentId);
            if (student == null)
            {
                return NotFound("Student not found.");
            }

            if (student.Points >= coupon.Fee)
            {
                // Generate a human-readable, unique 10-character code
                string uniqueCode;
                do
                {
                    uniqueCode = GenerateReadableCode(10);
                } while (await _context.ClaimedCoupons.AnyAsync(c => c.Code == uniqueCode));

                var claimedCoupon = new ClaimedCoupon
                {
                    CouponId = id,
                    StudentId = studentId,
                    Code = uniqueCode,
                    IsUsed = false,
                    ClaimedDate = DateTime.UtcNow,
                    ExpirationDate = DateTime.UtcNow.AddDays(30)
                };

                student.Points -= coupon.Fee;
                _context.Students.Update(student);  

                _context.ClaimedCoupons.Add(claimedCoupon);
                await _context.SaveChangesAsync();
                return Ok(claimedCoupon.Id);
            }
            else
            {
                 return BadRequest("Insufficient points to claim this coupon.");
            }

        }

        // Helper method to generate human-readable code
        private static string GenerateReadableCode(int length)
        {
            const string chars = "ABCDEFGHJKMNPQRSTUVWXYZ23456789"; // excludes 0, O, 1, I, L
            var random = new Random();
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }

        [HttpGet("claimed/student/{studentId}")]
        public async Task<ActionResult<List<ClaimedCouponDTO>>> GetClaimedCoupon(Guid studentId)
        {
            var claimedCoupons = await _context.ClaimedCoupons
                .Include(cc => cc.Coupon)
                .Include(cc => cc.Student)
                .Where(cc => cc.StudentId == studentId && cc.ExpirationDate >= DateTime.UtcNow)
                .Select(cc => new ClaimedCouponDTO()
                {
                    Id = cc.Id,
                    CouponName = cc.Coupon.Name,
                    CouponIcon = cc.Coupon.Icon,
                    CouponDescription = cc.Coupon.Description,
                    Code = cc.Code,
                    IsUsed = cc.IsUsed,
                    ClaimedDate = cc.ClaimedDate,
                    ExpirationDate = cc.ExpirationDate,
                })
                .ToListAsync();

            if (claimedCoupons == null)
            {
                return NotFound("No expired claimed coupons found.");
            }
            return Ok(claimedCoupons);
        }

    }
}
