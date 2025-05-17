namespace EduPilot.Api.DTOs
{
    public class QuestionAddDTO
    {
        public string QuestionContent { get; set; }
        public bool IsActive { get; set; }
        public IFormFile? File { get; set; }
        public List<ChoiceAddDTO> Choices { get; set; }
    }
}
