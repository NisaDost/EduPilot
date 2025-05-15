namespace EduPilot.Api.Data.Models
{
    public class Choice
    {
        public Guid Id { get; set; }
        public Guid QuestionId { get; set; }
        public string OptionContent { get; set; }
        public bool IsCorrect { get; set; }
        public bool IsActive { get; set; }
        public Question Question { get; set; }
        public List<SolvedQuizDetails> SolvedQuizDetails { get; set; }
    }
}
