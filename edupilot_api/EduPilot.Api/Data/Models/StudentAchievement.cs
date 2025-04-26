namespace EduPilot.Api.Data.Models
{
    public class StudentAchievement
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid AchievementId { get; set; }
        public Student Student { get; set; }
        public Achievement Achievement { get; set; }
    }
}
