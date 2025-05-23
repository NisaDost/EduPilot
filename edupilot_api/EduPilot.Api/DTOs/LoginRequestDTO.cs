﻿using System.ComponentModel.DataAnnotations;

namespace EduPilot.Api.Models
{
    public class LoginRequestDTO
    {
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
