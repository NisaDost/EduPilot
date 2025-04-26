namespace EduPilot.Api.Data.Models
{
    public class Student
    {
        public Guid Id { get; set; }
        public Guid? InstitutionId { get; set; }
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public int Points { get; set; }
        public int Grade { get; set; }
        public string Avatar { get; set; }
        public int DailyStreakCount { get; set; }
        public DateTime? LastLoginDate { get; set; }
        public Institution Institution { get; set; }
        public List<Attendance> Attendances { get; set; }
        public List<StudentSupervisor> StudentSupervisors { get; set; }
        public List<StudentFavLesson> StudentFavLessons { get; set; }
        public List<StudentAchievement> StudentAchievements { get; set; }
    }
}