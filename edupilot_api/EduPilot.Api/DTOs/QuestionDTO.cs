namespace EduPilot.Api.DTOs
{
    public class QuestionDTO
    {
        public Guid QuestionId { get; set; }
        public string QuestionContent { get; set; }
        public string? QuestionImage { get; set; }
        public bool IsActive { get; set; }
        public List<ChoiceDTO> Choices { get; set; }
    }
}
