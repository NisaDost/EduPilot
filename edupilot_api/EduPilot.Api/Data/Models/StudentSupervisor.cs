namespace EduPilot.Api.Data.Models
{
    public class StudentSupervisor
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid SupervisorId { get; set; }
        public Student Student { get; set; }
        public Supervisor Supervisor { get; set; }
    }
}
