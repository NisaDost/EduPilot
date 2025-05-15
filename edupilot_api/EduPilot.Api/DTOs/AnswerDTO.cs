namespace EduPilot.Api.DTOs
{
    public class AnswerDTO
    {
        public Guid QuestionId {  get; set; }
        public Guid? ChoiceId { get; set; }
    }
}
