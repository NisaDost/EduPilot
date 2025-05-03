using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/publisher")]
    [ApiController]
    [Authorize]
    public class PublishersController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public PublishersController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpPost("register")]
        public async Task<IActionResult> PostPublisher([FromBody] PublisherRegisterDTO publisher)
        {
            if (ModelState.IsValid)
            {
                if (await _context.Publishers.AnyAsync(s => s.Email == publisher.Email))
                {
                    ModelState.AddModelError("Email", "Bu e-posta adresi zaten kayıtlı.");
                    return BadRequest(ModelState);
                }
                var publisherEntity = new Publisher()
                {
                    Name = publisher.Name,
                    Email = publisher.Email,
                    Password = publisher.Password,
                    Address = publisher.Address,
                    Logo = publisher.Logo,
                    Website = publisher.Website,
                };
                _context.Publishers.Add(publisherEntity);
                await _context.SaveChangesAsync();
                return CreatedAtAction(nameof(PostPublisher), new { status = 201, id = publisherEntity.Id });
            }
            return BadRequest(ModelState);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutPublisher(Guid id, [FromBody] PublisherRegisterDTO publisher)
        {
            var publisherEntity = await _context.Publishers.FindAsync(id);
            if (publisherEntity == null)
            {
                return NotFound("Publisher not found");
            }
            publisherEntity.Name = publisher.Name;
            publisherEntity.Email = publisher.Email;
            publisherEntity.Password = publisher.Password;
            publisherEntity.Address = publisher.Address;
            publisherEntity.Logo = publisher.Logo;
            publisherEntity.Website = publisher.Website;
            _context.Entry(publisherEntity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpPost("addquiz")]
        public async Task<IActionResult> AddQuiz([FromBody] QuizDTO quiz)
        {
            if (ModelState.IsValid)
            {
                var quizEntity = new Quiz()
                {
                    SubjectId = quiz.SubjectId,
                    Difficulty = quiz.Difficulty,
                    PointPerQuestion = quiz.Difficulty == Difficulty.Easy ? 10 : quiz.Difficulty == Difficulty.Medium ? 20 : 40,
                    IsActive = true,
                    Questions = quiz.Questions.Select(q => new Question()
                    {
                        QuestionContent = q.QuestionContent,
                        Choices = q.Choices.Select(c => new Choice()
                        {
                            OptionContent = c.ChoiceContent,
                            IsCorrect = c.IsCorrect
                        }).ToList()
                    }).ToList(),
                };
                _context.Quizzes.Add(quizEntity);
                await _context.SaveChangesAsync();
                return CreatedAtAction(nameof(AddQuiz), new { status = 201, id = quizEntity.Id });
            }
            return BadRequest(ModelState);
        }

        [HttpGet("{id}/quizzes")]
        public async Task<IActionResult> GetQuizzes(Guid id)
        {
            var quizzes = await _context.Quizzes
                .Where(q => q.PublisherId == id)
                .Include(q => q.Subject)
                .Include(q => q.Questions)
                .ThenInclude(q => q.Choices)
                .ToListAsync();
            return Ok(quizzes);
        }

        [HttpPut("quizstate/{id}")]
        public async Task<IActionResult> UpdateQuizState(Guid id, [FromBody] bool isActive)
        {
            var quiz = await _context.Quizzes.FindAsync(id);
            if (quiz == null)
            {
                return NotFound("Quiz not found");
            }
            quiz.IsActive = isActive;
            _context.Quizzes.Update(quiz);
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}