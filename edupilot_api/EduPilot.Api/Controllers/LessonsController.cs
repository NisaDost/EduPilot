using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using EduPilot.Api.Data;
using EduPilot.Api.DTOs;
using Microsoft.AspNetCore.Authorization;

namespace EduPilot.Api.Controllers
{
    [Route("api")]
    [ApiController]
    [Authorize]
    public class LessonsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public LessonsController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet("lessons/{grade}")]
        public async Task<ActionResult<List<LessonsByGradeDTO>>> GetLessonsByGrade(int grade)
        {
            var lesson = await _context.Lessons.Where(l => l.Grade.Equals(grade))
                .Select(l => new LessonsByGradeDTO()
                {
                    Id = l.Id,
                    Name = l.Name,
                    Icon = l.Icon
                }).ToListAsync();

            if (lesson == null)
            {
                return NotFound();
            }

            return lesson;
        }
    }
}
