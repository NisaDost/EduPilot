namespace EduPilot.Api.Data.Models
{
    public class Student
    {
        public Guid Id { get; set; }
        public Guid? InstitutionId { get; set; }
        public string FirstName { get; set; }
        public string? MiddleName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public int Points { get; set; }
        public int Grade { get; set; }
        public string Avatar { get; set; }
        public int DailyStreakCount { get; set; }
        public DateTime? LastActivityDate { get; set; }
        public string? Mugshot { get; set; }
        public Institution Institution { get; set; }
        public List<Attendance> Attendances { get; set; }
        public List<StudentSupervisor> StudentSupervisors { get; set; }
        public List<StudentFavLesson> StudentFavLessons { get; set; }
        public List<StudentAchievement> StudentAchievements { get; set; }
        public List<StudentSimulation> StudentSimulations { get; set; }
        public List<ClaimedCoupon> ClaimedCoupons { get; set; }
        public List<SolvedQuestionCount> SolvedQuestionCounts { get; set; }
        public List<QuizResult> QuizResults { get; set; }
        public List<WeakSubjects> WeakSubjects { get; set; }
        public List<SolvedQuizDetails> SolvedQuizDetails { get; set; }
        public List<SolvedQuizInfo> SolvedQuizInfos { get; set; }
    }
}