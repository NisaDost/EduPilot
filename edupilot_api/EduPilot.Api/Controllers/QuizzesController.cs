using Azure.Storage.Blobs.Specialized;
using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using EduPilot.Api.Services;
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
        private readonly BlobService _blobService;

        public QuizController(ApiDbContext context, BlobService blobService)
        {
            _context = context;
            _blobService = blobService;
        }

        [HttpGet("quizinfo/{id}")]
        public async Task<ActionResult<QuizInfoDTO>> GetQuizInfoById(Guid id)
        {
            var quiz = await _context.Quizzes
                .Where(q => q.Id == id && q.IsActive)
                .Select(q => new QuizInfoDTO
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
                .Where(q => q.SubjectId == subjectId && q.IsActive)
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

        [HttpGet("quiz/{id}")]
        public async Task<ActionResult<QuizDTO>> GetQuizById(Guid id)
        {
            var sasToken = _blobService.GetAccountSasToken();

            var quiz = await _context.Quizzes
                .Where(q => q.Id == id && q.IsActive)
                .Select(q => new QuizDTO
                {
                    Id = id,
                    SubjectId = q.SubjectId,
                    Difficulty = q.Difficulty,
                    PointPerQuestion = q.PointPerQuestion,
                    Duration = q.Duration,
                    QuestionCount = q.Questions.Count(),
                    Questions = q.Questions.Select(q => new QuestionDTO
                    {
                        QuestionId = q.Id,
                        QuestionContent = q.QuestionContent,
                        QuestionImage = !string.IsNullOrWhiteSpace(q.QuestionImage) ? $"{q.QuestionImage}?{sasToken}" : String.Empty,
                        Choices = q.Choices.Select(c => new ChoiceDTO
                        {
                            ChoiceId = c.Id,
                            ChoiceContent = c.OptionContent,
                            IsCorrect = c.IsCorrect
                        }).ToList()
                    }).ToList()
                }).FirstOrDefaultAsync();
            if (quiz == null)
            {
                return NotFound();
            }
            return quiz;
        }

        [HttpPost("quiz/{id}/student/{studentId}")]
        public async Task<ActionResult<QuizResultDTO>> PostQuizResult(Guid id, Guid studentId, [FromBody] List<AnswerDTO> answers)
        {
            var student = await _context.Students.Where(s => s.Id == studentId).FirstOrDefaultAsync();
            if (student == null)
            {
                return NotFound();
            }

            var quiz = await _context.Quizzes.Where(q => q.Id == id).FirstOrDefaultAsync();
            if (quiz == null)
            {
                return NotFound();
            }

            var trueCount = 0;
            var falseCount = 0;
            var emptyCount = 0;

            foreach (var answer in answers)
            {
                var choices = await _context.Choices.Where(c => c.QuestionId == answer.QuestionId).ToListAsync();

                if (answer.ChoiceId == null)
                {
                    emptyCount++;
                }
                else
                {
                    if (choices.Any(c => c.Id == answer.ChoiceId && c.IsCorrect))
                    {
                        trueCount++;
                    }
                    else if (choices.Any(c => c.Id == answer.ChoiceId && !c.IsCorrect))
                    {
                        falseCount++;
                    }
                }

                var solvedQuizEntity = new SolvedQuizDetails
                {
                    QuizId = id,
                    StudentId = studentId,
                    QuestionId = answer.QuestionId,
                    SelectedChoiceId = answer.ChoiceId
                };
                _context.SolvedQuizDetails.Add(solvedQuizEntity);
            }

            var answerEntity = new QuizResult
            {
                QuizId = id,
                StudentId = studentId,
                SubjectId = quiz.SubjectId,
                QuizDifficulty = quiz.Difficulty,
                TrueAnswerCount = trueCount,
                FalseAnswerCount = falseCount,
                EmptyAnswerCount = emptyCount,
            };

            if (answerEntity == null)
            {
                return BadRequest();
            }
            _context.QuizResults.Add(answerEntity);

            var totalQuestionCount = answerEntity.TrueAnswerCount + answerEntity.FalseAnswerCount + answerEntity.EmptyAnswerCount;

            if ((answerEntity.QuizDifficulty == Difficulty.Easy && answerEntity.TrueAnswerCount <= totalQuestionCount * 0.8)
                || (answerEntity.QuizDifficulty == Difficulty.Medium && answerEntity.TrueAnswerCount <= totalQuestionCount * 0.6)
                || (answerEntity.QuizDifficulty == Difficulty.Hard && answerEntity.TrueAnswerCount <= totalQuestionCount * 0.4))
            {
                _context.Entry(answerEntity).Reference(a => a.Subject).Load();
                var weakSubjectEntity = new WeakSubjects
                {
                    StudentId = studentId,
                    SubjectId = answerEntity.SubjectId,
                    SubjectName = answerEntity.Subject.Name,
                    Date = DateTime.Now.Date,
                };
                _context.WeakSubjects.Add(weakSubjectEntity);
            }

            var earnedPoints = trueCount * quiz.PointPerQuestion;
            if (earnedPoints > 0)
            {
                student.Points += earnedPoints;
                if (student.LastActivityDate == DateTime.Now.Date.AddDays(-1))
                {
                    student.DailyStreakCount++;
                }
                else
                {
                    student.DailyStreakCount = 0;
                }
                student.LastActivityDate = DateTime.Now.Date;
                _context.Students.Update(student);
            }

            var solvedQuizInfo = new SolvedQuizInfo
            {
                StudentId = studentId,
                QuizId = answerEntity.QuizId,
                Difficulty = quiz.Difficulty,
                TrueCount = trueCount,
                FalseCount = falseCount,
                EmptyCount = emptyCount,
                TotalQuestionCount = totalQuestionCount,
                EarnedPoints = earnedPoints,
                Duration = quiz.Duration,
                SolvedDate = DateTime.Now.Date,
            };
            _context.SolvedQuizInfos.Add(solvedQuizInfo);

            await _context.SaveChangesAsync();

            return Ok(new QuizResultDTO { TrueCount = trueCount, FalseCount = falseCount, EmptyCount = emptyCount, TotalCount = totalQuestionCount, EarnedPoints = earnedPoints });
        }

        [HttpGet("solvedquiz/{id}/student/{studentId}")]
        public async Task<ActionResult<SolvedQuizDTO>> GetSolvedQuiz(Guid id, Guid studentId)
        {
            var solvedQuizDetails = await _context.SolvedQuizDetails
                .Include(sqd => sqd.Quiz)
                .ThenInclude(q => q.Questions)
                .ThenInclude(q => q.Choices)
                .Where(sqd => sqd.QuizId == id && sqd.StudentId == studentId)
                .ToListAsync();

            if (solvedQuizDetails == null || !solvedQuizDetails.Any())
            {
                return NotFound();
            }

            var quiz = solvedQuizDetails.First().Quiz;

            var sasToken = _blobService.GetAccountSasToken();

            var solvedQuizDTO = new SolvedQuizDTO
            {
                Id = quiz.Id,
                SubjectId = quiz.SubjectId,
                Difficulty = quiz.Difficulty,
                PointPerQuestion = quiz.PointPerQuestion,
                Duration = quiz.Duration,
                QuestionCount = quiz.Questions.Count,
                SolvedQuestions = quiz.Questions.Select(q => new SolvedQuestionDTO
                {
                    QuestionContent = q.QuestionContent,
                    QuestionImage = !string.IsNullOrWhiteSpace(q.QuestionImage) ? $"{q.QuestionImage}?{sasToken}" : String.Empty,
                    SelectedChoiceId = solvedQuizDetails
                        .FirstOrDefault(sqd => sqd.QuestionId == q.Id)?.SelectedChoiceId ?? Guid.Empty,
                    Choices = q.Choices.Select(c => new ChoiceDTO
                    {
                        ChoiceId = c.Id,
                        ChoiceContent = c.OptionContent,
                        IsCorrect = c.IsCorrect
                    }).ToList()
                }).ToList()
            };

            return solvedQuizDTO;
        }

        [HttpGet("solvedquizinfo/student/{studentId}")]
        public async Task<ActionResult<List<SolvedQuizInfoDTO>>> GetSolvedQuizInfo(Guid studentId)
        {
            var solvedQuiz = await _context.SolvedQuizInfos
                .Include(sqi => sqi.Quiz)
                .Where(sqi => sqi.StudentId == studentId && sqi.Quiz.Id == sqi.QuizId)
                .Select(sqi => new SolvedQuizInfoDTO
                {
                    QuizId = sqi.QuizId,
                    SubjectId = sqi.Quiz.SubjectId,
                    SubjectName = sqi.Quiz.Subject.Name,
                    Difficulty = sqi.Difficulty,
                    TrueCount = sqi.TrueCount,
                    FalseCount = sqi.FalseCount,
                    EmptyCount = sqi.EmptyCount,
                    TotalQuestionCount = sqi.TotalQuestionCount,
                    EarnedPoints = sqi.EarnedPoints,
                    Duration = sqi.Duration,
                    SolvedDate = sqi.SolvedDate,
                }).ToListAsync();

            if (solvedQuiz == null)
            {
                return NotFound();
            }

            return solvedQuiz;
        }
    }
}
