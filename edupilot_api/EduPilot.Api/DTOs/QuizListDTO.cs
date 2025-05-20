using EduPilot.Api.Data.Models;

namespace EduPilot.Api.DTOs
{
    public class QuizListDTO
    {
        public Guid Id { get; set; }
        public string SubjectName { get; set; }
        public Difficulty Difficulty { get; set; }
        public int Duration { get; set; }
        public int QuestionCount { get; set; }
        public bool IsActive { get; set; }
    }
}
