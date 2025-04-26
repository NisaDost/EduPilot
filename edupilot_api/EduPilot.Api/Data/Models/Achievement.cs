namespace EduPilot.Api.Data.Models
{
    public class Achievement
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Icon { get; set; }
        public List<StudentAchievement> StudentAchievements { get; set; }
    }
}
