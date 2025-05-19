using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using EduPilot.Api.Services;
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
        private readonly BlobService _blobService;

        public PublishersController(ApiDbContext context, BlobService blobService)
        {
            _context = context;
            _blobService = blobService;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PublisherDTO>> GetPublisherById(Guid id)
        {
            var quizCount = await _context.Quizzes
                .Where(q => q.PublisherId == id)
                .CountAsync();

            var questionCount = await _context.Questions
                .Where(q => q.Quiz.PublisherId == id)
                .CountAsync();

            var publisher = await _context.Publishers
                .Select(p => new PublisherDTO()
                {
                    Id = p.Id,
                    Name = p.Name,
                    Email = p.Email,
                    Address = p.Address ?? string.Empty,
                    Logo = p.Logo ?? string.Empty,
                    Website = p.Website ?? string.Empty,
                    quizCount = quizCount,
                    questionCount = questionCount
                })
                .FirstOrDefaultAsync(x => x.Id == id);

            if (publisher == null)
            {
                return NotFound();
            }

            return publisher;
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
            if (publisherEntity.Password == publisher.CurrentPassword)
            {
                publisherEntity.Name = publisher.Name;
                publisherEntity.Password = publisher.Password;
                publisherEntity.Address = publisher.Address;
                publisherEntity.Logo = publisher.Logo;
                publisherEntity.Website = publisher.Website;
                _context.Entry(publisherEntity).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return Ok();
            }
            return BadRequest();
        }

        [HttpPost("{id}/add/quiz")]
        public async Task<IActionResult> AddQuiz(Guid id, [FromForm] QuizDTO quiz)
        {
            if (ModelState.IsValid)
            {
                var quizEntity = new Quiz()
                {
                    PublisherId = id,
                    SubjectId = quiz.SubjectId,
                    Difficulty = quiz.Difficulty,
                    PointPerQuestion = quiz.Difficulty == Difficulty.Easy ? 10 : quiz.Difficulty == Difficulty.Medium ? 20 : 40,
                    Duration = quiz.Duration,
                    IsActive = quiz.IsActive,
                    Questions = quiz.Questions.Select(q => new Question()
                    {
                        QuestionContent = q.QuestionContent,
                        IsActive = true,
                        Choices = q.Choices.Select(c => new Choice()
                        {
                            OptionContent = c.ChoiceContent,
                            IsCorrect = c.IsCorrect
                        }).ToList()
                    }).ToList(),
                };
                _context.Quizzes.Add(quizEntity);
                await _context.SaveChangesAsync();

                for (int i = 0; i < quiz.Questions.Count; i++)
                {
                    var questionDTO = quiz.Questions[i];
                    var questionEntity = quizEntity.Questions[i];
                    questionEntity.QuestionImage = String.Empty;

                    if (questionDTO.File != null)
                    {
                        string fileUrl = await _blobService.UploadQuestionFileAsync(questionDTO.File, quizEntity.Id, questionEntity.Id);

                        questionEntity.QuestionImage = fileUrl;
                    }
                }

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

        [HttpPost("question/quiz/{id}")]
        public async Task<IActionResult> AddQuestionToQuiz(Guid id, [FromForm] QuestionAddDTO question)
        {
            var quiz = await _context.Quizzes
                .Include(q => q.Questions) // Ensure questions are included
                .FirstOrDefaultAsync(q => q.Id == id);

            if (quiz == null)
            {
                return NotFound("Quiz not found");
            }

            var questionEntity = new Question()
            {
                QuestionContent = question.QuestionContent,
                Choices = question.Choices.Select(c => new Choice()
                {
                    OptionContent = c.ChoiceContent,
                    IsCorrect = c.IsCorrect
                }).ToList()
            };
            quiz.Questions.Add(questionEntity);
            _context.Quizzes.Update(quiz);
            await _context.SaveChangesAsync();

            if (question.File != null)
            {
                string fileUrl = await _blobService.UploadQuestionFileAsync(question.File, quiz.Id, questionEntity.Id);

                questionEntity.QuestionImage = fileUrl;
            }

            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(AddQuestionToQuiz), new { status = 201, id = questionEntity.Id });
        }
    }
}