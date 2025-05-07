namespace EduPilot.Api.Data.Models
{
    public class StudentSimulation
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid SimulationId { get; set; }
        public DateTime StudiedAt { get; set; }
        public Student Student { get; set; }
        public Simulation Simulation { get; set; }
    }
}
