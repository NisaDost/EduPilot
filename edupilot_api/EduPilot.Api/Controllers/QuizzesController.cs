using EduPilot.Api.Data;
using EduPilot.Api.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api")]
    [ApiController]
    [Authorize]
    public class QuizController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public QuizController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet("quiz/{id}")]
        public async Task<ActionResult<QuizDTO>> GetQuizInfoById(Guid id)
        {
            var quiz = await _context.Quizzes
                .Where(q => q.Id == id)
                .Select(q => new QuizDTO
                {
                    Id = q.Id,
                    SubjectId = q.SubjectId,
                    Difficulty = q.Difficulty,
                    Duration = q.Duration,
                    PointPerQuestion = q.PointPerQuestion,
                    QuestionCount = q.Questions.Count,
                }).FirstOrDefaultAsync();
            if (quiz == null)
            {
                return NotFound();
            }
            return quiz;
        }

        [HttpGet("quizzes/subject/{subjectId}")]
        public async Task<ActionResult<List<QuizDTO>>> GetQuizzesBySubjectId(Guid subjectId)
        {
            var quizzes = await _context.Quizzes
                .Where(q => q.SubjectId == subjectId)
                .Select(q => new QuizDTO
                {
                    SubjectId = q.SubjectId,
                    Difficulty = q.Difficulty,
                    PointPerQuestion = q.PointPerQuestion,
                    Questions = q.Questions.Select(q => new QuestionDTO
                    {
                        QuestionContent = q.QuestionContent,
                        QuestionImage = q.QuestionImage,
                        Choices = q.Choices.Select(c => new ChoiceDTO
                        {
                            ChoiceContent = c.OptionContent,
                            IsCorrect = c.IsCorrect
                        }).ToList()
                    }).ToList()
                }).ToListAsync();
            if (quizzes == null)
            {
                return NotFound();
            }
            return quizzes;
        }
    }
}
