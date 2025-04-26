namespace EduPilot.Api.DTOs
{
    public class StudentDTO
    {
        public Guid StudentId { get; set; }
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; }
        public int Grade { get; set; }
        public string Avatar { get; set; }
        public int DailyStreakCount { get; set; }
        public int Points { get; set; }
        public string? InstitutionName { get; set; }
        public List<FavoriteLessonDTO> FavoriteLessons { get; set; }
        public List<StudentAchievementDTO>? StudentAchievements { get; set; }
        public List<StudentSupervisorDTO>? StudentSupervisors { get; set; }
    }
}
