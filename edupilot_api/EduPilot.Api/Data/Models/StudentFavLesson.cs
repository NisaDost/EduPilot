namespace EduPilot.Api.Data.Models
{
    public class StudentFavLesson
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid LessonId { get; set; }
        public Student Student { get; set; }
        public Lesson Lesson { get; set; }
    }
}