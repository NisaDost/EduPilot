namespace EduPilot.Api.Data.Models
{
    public class Lesson
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Icon { get; set; }
        public int Grade { get; set; }
        public List<Attendance> Attendances { get; set; }
        public List<StudentFavLesson> StudentFavLessons { get; set; }
    }
}
