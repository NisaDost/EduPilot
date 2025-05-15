namespace EduPilot.Api.DTOs
{
    public class SolvedQuestionDTO
    {
        public string QuestionContent { get; set; }
        public string? QuestionImage { get; set; }
        public Guid? SelectedChoiceId { get; set; }
        public List<ChoiceDTO> Choices { get; set; }
    }
}
