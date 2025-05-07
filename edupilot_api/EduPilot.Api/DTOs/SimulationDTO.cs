namespace EduPilot.Api.DTOs
{
    public class SimulationDTO
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public int StudyDuration { get; set; }
        public int BreakDuration { get; set; }
    }
}
