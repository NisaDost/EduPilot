using EduPilot.Api.Data.Models;

namespace EduPilot.Api.DTOs
{
    public class SolvedQuizInfoDTO
    {
        public Guid QuizId { get; set; }
        public Guid SubjectId { get; set; }
        public string SubjectName { get; set; }
        public Difficulty Difficulty { get; set; }
        public int TrueCount { get; set; }
        public int FalseCount { get; set; }
        public int EmptyCount { get; set; }
        public int TotalQuestionCount { get; set; }
        public int EarnedPoints { get; set; }
        public int Duration { get; set; }
        public DateTime SolvedDate { get; set; }
    }
}
