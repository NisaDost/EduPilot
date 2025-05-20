namespace EduPilot.Api.DTOs
{
    public class QuestionUpdateDTO
    {
        public Guid QuestionId { get; set; }
        public string QuestionContent { get; set; }
        public bool IsActive { get; set; }
        public string? QuestionImage { get; set; }
        public IFormFile? File { get; set; }
        public List<ChoiceDTO> Choices { get; set; }
    }
}
