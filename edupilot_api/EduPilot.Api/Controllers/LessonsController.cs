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

        [HttpGet("lessons/{lessonId}/subjects")]
        public async Task<ActionResult<List<SubjectDTO>>> GetSubjectsByLessonId(Guid lessonId)
        {
            var subjects = await _context.Subjects
                .Where(s => s.LessonId.Equals(lessonId))
                .Select(s => new SubjectDTO()
                {
                    Id = s.Id,
                    LessonId = s.LessonId,
                    Name = s.Name,
                    Grade = s.Grade
                }).ToListAsync();

            if (subjects == null || !subjects.Any())
            {
                return NotFound();
            }
            return subjects;
        }

        [HttpGet("lessons/{lessonId}/subjects/student/{studentId}")]
        public async Task<ActionResult<List<SubjectDTO>>> GetSubjectsByLessonId(Guid lessonId, Guid studentId)
        {
            var subjects = await _context.Subjects
                .Where(s => s.LessonId.Equals(lessonId))
                .Select(s => new SubjectDTO()
                {
                    Id = s.Id,
                    LessonId = s.LessonId,
                    Name = s.Name,
                    Grade = s.Grade,
                    Quizzes = s.Quizzes.Where(q => q.IsActive && !q.SolvedQuizDetails.Any(sqd => sqd.QuizId == q.Id && sqd.StudentId == studentId)).Select(q => new SubjectQuizDTO()
                    {
                        QuizId = q.Id,
                        SubjectId = q.SubjectId,
                    }).ToList()
                }).ToListAsync();

            if (subjects == null || !subjects.Any())
            {
                return NotFound();
            }
            return subjects;
        }
    }
}
