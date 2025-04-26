using EduPilot.Api.Data;
using EduPilot.Api.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/auth")]
    [ApiController]
    [Authorize]
    public class AuthController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public AuthController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public ActionResult<string> Get()
        {
            return "Auth endpoint";
        }

        [HttpPost("login")]
        public async Task<ActionResult<Guid>> StudentLogin([FromBody] StudentLoginRequestDTO request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var student = await _context.Students.FirstOrDefaultAsync(s => s.Email == request.Email && s.Password == request.Password);

            if (student == null)
            {
                return Unauthorized("Invalid email or password");
            }

            return Ok(student.Id);
        }
    }
}