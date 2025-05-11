namespace EduPilot.Api.DTOs
{
    public class SolvedQuestionCountDTO
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid LessonId { get; set; }
        public string LessonName { get; set; }
        public int Count { get; set; }
        public DateTime EntryDate { get; set; }
        public DateTime StartOfWeek { get; set; }
        public DateTime EndOfWeek { get; set; }
    }
}
