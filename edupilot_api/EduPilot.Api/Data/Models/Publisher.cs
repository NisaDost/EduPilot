﻿namespace EduPilot.Api.Data.Models
{
    public class Publisher
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string? Address { get; set; }
        public string? Logo { get; set; }
        public string? Website { get; set; }
        public List<Quiz> Quizzes { get; set; }
    }
}
