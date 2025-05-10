namespace EduPilot.Api.DTOs
{
    public class PublisherDTO
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Logo { get; set; }
        public string Address { get; set; }
        public string Website { get; set; }
        public int quizCount { get; set; }
        public int questionCount { get; set; }
    }
}
