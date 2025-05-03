using EduPilot.Api.Data;
using EduPilot.Api.DTOs;
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

        [HttpPost("login/institution")]
        public async Task<ActionResult<Guid>> InstitutionLogin([FromBody] InstitutionLoginRequestDTO request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            var institution = await _context.Institutions.FirstOrDefaultAsync(i => i.Email == request.Email && i.Password == request.Password);
            if (institution == null)
            {
                return Unauthorized("Invalid email or password");
            }
            return Ok(institution.Id);
        }
    }
}