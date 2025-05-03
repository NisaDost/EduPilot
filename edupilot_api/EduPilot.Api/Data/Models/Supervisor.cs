namespace EduPilot.Api.Data.Models
{
    public class Supervisor
    {
        public Guid Id { get; set; }
        public Guid? InstitutionId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public int UniqueCode { get; set; }
        public Institution Institution { get; set; }
        public List<StudentSupervisor> StudentSupervisors { get; set; }
    }
}
