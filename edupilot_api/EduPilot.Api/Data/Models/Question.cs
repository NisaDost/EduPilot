namespace EduPilot.Api.Data.Models
{
    public class Question
    {
        public Guid Id { get; set; }
        public Guid QuizId { get; set; }
        public Guid SubjectId { get; set; }
        public string QuestionContent { get; set; }
        public bool IsActive { get; set; } = true;
        public List<Choice> Choices { get; set; }
        public Quiz Quiz { get; set; }
        public Subject Subject { get; set; }
    }
}