namespace EduPilot.Api.DTOs
{
    public class SupervisorInfoDTO
    {
        public List<SupervisorStudentsInfoDTO>? Students { get; set; }
        public Guid? InstitutionId { get; set; }
        public string? InstitutionName { get; set; }
    }

    public class SupervisorStudentsInfoDTO
    {
        public Guid StudentId { get; set; }
        public string StudentFirstName { get; set; }
        public string? StudentMiddleName { get; set; }
        public string StudentLastName { get; set; }
        public int StudentGrade { get; set; }
    }
}
