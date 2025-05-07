namespace EduPilot.Api.DTOs
{
    public class StudentSimulationDTO
    {
        public Guid SimulationId { get; set; }
        public Guid StudentId { get; set; }
        public DateTime StudyDate { get; set; }
    }
}
