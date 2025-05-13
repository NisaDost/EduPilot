namespace EduPilot.Api.Data.Models
{
    public class Attendance
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid LessonId { get; set; }
        public DateTime Date { get; set; }
        public bool IsPresent { get; set; }
        public string Emotion { get; set; }
        public Student Student { get; set; }
        public Lesson Lesson { get; set; }
    }
}
