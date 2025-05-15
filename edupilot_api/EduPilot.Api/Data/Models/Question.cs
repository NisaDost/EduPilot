namespace EduPilot.Api.Data.Models
{
    public class Question
    {
        public Guid Id { get; set; }
        public Guid QuizId { get; set; }
        public string QuestionContent { get; set; }
        public string? QuestionImage { get; set; }
        public bool IsActive { get; set; }
        public List<Choice> Choices { get; set; }
        public Quiz Quiz { get; set; }
        public List<SolvedQuizDetails> SolvedQuizDetails { get; set; }
    }
}