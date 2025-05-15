namespace EduPilot.Api.Data.Models
{
    public class QuizResult
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid QuizId { get; set; }
        public Guid SubjectId { get; set; }
        public Difficulty QuizDifficulty { get; set; }
        public int TrueAnswerCount { get; set; }
        public int FalseAnswerCount { get; set; }
        public int EmptyAnswerCount { get; set; }
        public Student Student { get; set; }
        public Quiz Quiz { get; set; }
        public Subject Subject { get; set; }
    }
}
