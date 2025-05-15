namespace EduPilot.Api.DTOs
{
    public class QuizResultDTO
    {
        public int TrueCount { get; set; }
        public int FalseCount { get; set; }
        public int EmptyCount { get; set; }
        public int TotalCount { get; set; }
        public int EarnedPoints {  get; set; }
    }
}
