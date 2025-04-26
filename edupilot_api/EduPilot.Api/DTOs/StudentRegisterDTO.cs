using Newtonsoft.Json.Serialization;
using System.ComponentModel.DataAnnotations;

namespace EduPilot.Api.Models
{
    public class StudentRegisterDTO
    {
        [Required]
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        [Required]
        public string LastName { get; set; }
        [Required]
        [Range(1, 12, ErrorMessage = "Sınıf 1 ile 12 arasında olmalıdır.")]
        public int Grade { get; set; }
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        [Required]
        [DataType(DataType.PhoneNumber)]
        public string PhoneNumber { get; set; }
        [Required]
        public string Avatar { get; set; }
        [Required]
        public List<Guid> FavoriteLessons { get; set; }
        public int? SupervisorUniqueCode { get; set; }
        public string? SupervisorName { get; set; }
    }
}
