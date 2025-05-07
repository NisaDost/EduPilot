using EduPilot.Api.Data;
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
    }
}
