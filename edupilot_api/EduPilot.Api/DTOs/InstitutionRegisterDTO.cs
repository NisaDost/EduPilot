﻿namespace EduPilot.Api.DTOs
{
    public class InstitutionRegisterDTO
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string? NewPassword { get; set; }
        public string? Address { get; set; }
        public string? Logo { get; set; }
        public IFormFile? File { get; set; }
        public string? Website { get; set; }
    }
}
