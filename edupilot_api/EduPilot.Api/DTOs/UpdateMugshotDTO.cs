namespace EduPilot.Api.DTOs
{
    public class UpdateMugshotDTO
    {
        public Guid InstitutionId { get; set; }
        public IFormFile Mugshot { get; set; }
    }
}