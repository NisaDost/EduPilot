﻿namespace EduPilot.Api.DTOs
{
    public class InstitutionStudentDTO
    {
        public Guid StudentId { get; set; }
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; }
        public int Grade { get; set; }
        public string Email { get; set; }
        public string? Mugshot { get; set; }
        public List<string>? SupervisorName { get; set; }
    }
}
