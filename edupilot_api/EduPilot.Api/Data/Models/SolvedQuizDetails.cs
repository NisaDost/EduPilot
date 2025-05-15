namespace EduPilot.Api.Data.Models
{
    public class SolvedQuizDetails
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid QuizId { get; set; }
        public Guid QuestionId { get; set; }
        public Guid? SelectedChoiceId { get; set; }
        public Quiz Quiz { get; set; }
        public Student Student { get; set; }
        public Question Question { get; set; }
        public Choice SelectedChoice { get; set; }
    }
}
