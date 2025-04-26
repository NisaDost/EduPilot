namespace EduPilot.Api.Data.Models
{
    public class SolvedQuestionCount
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid LessonId { get; set; }
        public int Count { get; set; }
        public DateTime EntryDate { get; set; }
        public Student Student { get; set; }
        public Lesson Lesson { get; set; }
    }
}