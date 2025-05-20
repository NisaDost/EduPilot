namespace EduPilot.Api.DTOs
{
    public class SupervisorDTO
    {
        public Guid Id { get; set; }
        public Guid? InstitutionId { get; set; }
        public List<Guid>? StudentIds { get; set; }
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public int UniqueCode { get; set; }
    }
}
