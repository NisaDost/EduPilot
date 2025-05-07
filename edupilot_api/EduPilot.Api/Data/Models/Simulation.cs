namespace EduPilot.Api.Data.Models
{
    public class Simulation
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public int StudyDuration { get; set; }
        public int BreakDuration { get; set; }
        public List<StudentSimulation> StudentSimulations { get; set; }
    }
}
