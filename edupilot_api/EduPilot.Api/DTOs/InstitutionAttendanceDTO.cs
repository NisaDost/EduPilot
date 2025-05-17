namespace EduPilot.Api.DTOs
{
    public class InstitutionAttendanceDTO
    {
        public Guid AttendanceId { get; set; }
        public Guid InstitutionId { get; set; }
        public Guid StudentId { get; set; }
        public Guid LessonId { get; set; }
        public DateTime Date { get; set; }
        public bool IsPresent { get; set; }
        public string Emotion { get; set; }
    }
}
