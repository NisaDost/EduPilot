using EduPilot.Api.Data.Models;

namespace EduPilot.Api.DTOs
{
    public class QuizInfoDTO
    {
        public Guid Id { get; set; }
        public Guid SubjectId { get; set; }
        public Difficulty Difficulty { get; set; }
        public int PointPerQuestion { get; set; }
        public int Duration { get; set; }
        public bool IsActive { get; set; }
        public int QuestionCount { get; set; }
    }
}
