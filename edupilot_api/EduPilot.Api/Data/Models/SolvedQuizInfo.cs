namespace EduPilot.Api.Data.Models
{
    public class SolvedQuizInfo
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid QuizId { get; set; }
        public Difficulty Difficulty { get; set; }
        public int TrueCount { get; set; }
        public int FalseCount { get; set; }
        public int EmptyCount { get; set; }
        public int TotalQuestionCount { get; set; }
        public int EarnedPoints { get; set; }
        public int Duration { get; set; }
        public DateTime SolvedDate { get; set; }
        public Student Student { get; set; }
        public Quiz Quiz { get; set; }
    }
}
