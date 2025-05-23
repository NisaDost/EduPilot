﻿namespace EduPilot.Api.Data.Models
{
    public class Subject
    {
        public Guid Id { get; set; }
        public Guid LessonId { get; set; }
        public string Name { get; set; }
        public int Grade { get; set; }
        public Lesson Lesson { get; set; }
        public List<Quiz> Quizzes { get; set; }
        public List<QuizResult> QuizResutls { get; set; }
        public List<WeakSubjects> WeakSubjects { get; set; }
    }
}
