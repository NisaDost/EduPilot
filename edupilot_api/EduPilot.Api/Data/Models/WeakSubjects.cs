namespace EduPilot.Api.Data.Models
{
    public class WeakSubjects
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid SubjectId { get; set; }
        public string SubjectName { get; set; }
        public DateTime Date { get; set; }
        public Student Student { get; set; }
        public Subject Subject { get; set; }
        public Lesson Lesson { get; set; }
    }
}
