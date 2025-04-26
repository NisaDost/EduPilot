namespace EduPilot.Api.Data.Models
{
    public class Quiz
    {
        public Guid Id { get; set; }
        public List<Question> Questions { get; set; }
        public Guid SubjectId { get; set; }
        public Difficulty Difficulty { get; set; }
        public int PointPerQuestion { get; set; }
        public bool IsActive { get; set; }
        public Subject Subject { get; set; }

    }
}
