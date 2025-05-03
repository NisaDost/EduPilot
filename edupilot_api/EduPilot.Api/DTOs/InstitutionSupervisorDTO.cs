namespace EduPilot.Api.DTOs
{
    public class InstitutionSupervisorDTO
    {
        public Guid SupervisorId { get; set; }
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
    }
}
