using EduPilot.Api.Data.Models;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Data
{
    public class ApiDbContext : DbContext
    {
        public ApiDbContext(DbContextOptions<ApiDbContext> options) : base(options)
        {

        }
        public DbSet<Student> Students { get; set; }
        public DbSet<Institution> Institutions { get; set; }
        public DbSet<Attendance> Attendances { get; set; }
        public DbSet<Lesson> Lessons { get; set; }
        public DbSet<Subject> Subjects { get; set; }
        public DbSet<Supervisor> Supervisors { get; set; }
        public DbSet<Achievement> Achievements { get; set; }
        public DbSet<Publisher> Publishers { get; set; }
        public DbSet<Quiz> Quizzes { get; set; }
        public DbSet<Question> Questions { get; set; }
        public DbSet<Choice> Choices { get; set; }
        public DbSet<StudentFavLesson> StudentFavLessons { get; set; }
        public DbSet<StudentAchievement> StudentAchievements { get; set; }
        public DbSet<StudentSupervisor> StudentSupervisors { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Add any additional configuration here  
            #region Student
            modelBuilder.Entity<Student>()
                .HasMany(s => s.StudentSupervisors)
                .WithOne()
                .HasForeignKey(ss => ss.StudentId)
                .HasForeignKey(ss => ss.SupervisorId)
                .IsRequired(false)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Student>()
                .HasMany(s => s.StudentAchievements)
                .WithOne()
                .HasForeignKey(sa => sa.StudentId)
                .HasForeignKey(sa => sa.AchievementId)
                .IsRequired(false)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Student>()
                .HasMany(s => s.StudentFavLessons)
                .WithOne()
                .HasForeignKey(sl => sl.StudentId)
                .HasForeignKey(sl => sl.LessonId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Student>()
                .HasMany(s => s.Attendances)
                .WithOne()
                .HasForeignKey(a => a.StudentId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Student>()
                .HasOne(s => s.Institution)
                .WithMany(i => i.Students)
                .HasForeignKey(s => s.InstitutionId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Student>()
                .HasKey(s => s.Id);
            modelBuilder.Entity<Student>()
                .Property(s => s.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Student>()
                .Property(s => s.InstitutionId)
                .IsRequired(false);
            modelBuilder.Entity<Student>()
                .Property(s => s.FirstName)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Student>()
                .Property(s => s.MiddleName)
                .HasMaxLength(50)
                .IsRequired(false);
            modelBuilder.Entity<Student>()
                .Property(s => s.LastName)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Student>()
                .Property(s => s.Email)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Student>()
                .Property(s => s.Password)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Student>()
                .Property(s => s.PhoneNumber)
                .IsRequired()
                .HasMaxLength(11);
            modelBuilder.Entity<Student>()
                .Property(s => s.Points)
                .IsRequired()
                .HasDefaultValue(0);
            modelBuilder.Entity<Student>()
                .Property(s => s.Grade)
                .IsRequired();
            modelBuilder.Entity<Student>()
                .Property(s => s.DailyStreakCount)
                .IsRequired()
                .HasDefaultValue(0);
            modelBuilder.Entity<Student>()
                .Property(s => s.LastLoginDate)
                .IsRequired(false);
            #endregion

            #region Institution
            modelBuilder.Entity<Institution>()
                .HasMany(i => i.Students)
                .WithOne(s => s.Institution)
                .HasForeignKey(s => s.InstitutionId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Institution>()
                .HasMany(i => i.Supervisors)
                .WithOne(s => s.Institution)
                .HasForeignKey(s => s.InstitutionId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Institution>()
                .HasKey(i => i.Id);
            modelBuilder.Entity<Institution>()
                .Property(i => i.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Institution>()
                .Property(i => i.Name)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Institution>()
                .Property(i => i.Email)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Institution>()
                .Property(i => i.Password)
                .IsRequired()
                .HasMaxLength(50);
            modelBuilder.Entity<Institution>()
                .Property(i => i.Address)
                .IsRequired(false)
                .HasMaxLength(250);
            modelBuilder.Entity<Institution>()
                .Property(i => i.Logo)
                .IsRequired(false)
                .HasMaxLength(250);
            modelBuilder.Entity<Institution>()
                .Property(i => i.Website)
                .IsRequired(false)
                .HasMaxLength(250);
            #endregion

            #region Attendance
            modelBuilder.Entity<Attendance>()
                .HasKey(a => a.Id);
            modelBuilder.Entity<Attendance>()
                .Property(a => a.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Attendance>()
                .Property(a => a.StudentId)
                .IsRequired();
            modelBuilder.Entity<Attendance>()
                .Property(a => a.LessonId)
                .IsRequired();
            modelBuilder.Entity<Attendance>()
                .Property(a => a.Date)
                .IsRequired()
                .HasDefaultValueSql("CAST(GETDATE() AS DATE)");
            modelBuilder.Entity<Attendance>()
                .Property(a => a.IsPresent)
                .IsRequired()
                .HasDefaultValue(false);
            modelBuilder.Entity<Attendance>()
                .HasOne(a => a.Student)
                .WithMany(s => s.Attendances)
                .HasForeignKey(a => a.StudentId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Attendance>()
                .HasOne(a => a.Lesson)
                .WithMany(l => l.Attendances)
                .HasForeignKey(a => a.LessonId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region StudentSupervisor   
            modelBuilder.Entity<StudentSupervisor>()
                .HasKey(ss => ss.Id);
            modelBuilder.Entity<StudentSupervisor>()
                .Property(ss => ss.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<StudentSupervisor>()
                .Property(ss => ss.StudentId)
                .IsRequired();
            modelBuilder.Entity<StudentSupervisor>()
                .Property(ss => ss.SupervisorId)
                .IsRequired();
            modelBuilder.Entity<StudentSupervisor>()
                .HasOne(ss => ss.Student)
                .WithMany(s => s.StudentSupervisors)
                .HasForeignKey(ss => ss.StudentId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<StudentSupervisor>()
                .HasOne(ss => ss.Supervisor)
                .WithMany(s => s.StudentSupervisors)
                .HasForeignKey(ss => ss.SupervisorId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region StudentFavLesson
            modelBuilder.Entity<StudentFavLesson>()
                .HasKey(sl => sl.Id);
            modelBuilder.Entity<StudentFavLesson>()
                .Property(sl => sl.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<StudentFavLesson>()
                .Property(sl => sl.StudentId)
                .IsRequired();
            modelBuilder.Entity<StudentFavLesson>()
                .Property(sl => sl.LessonId)
                .IsRequired();
            modelBuilder.Entity<StudentFavLesson>()
                .HasOne(sl => sl.Student)
                .WithMany(s => s.StudentFavLessons)
                .HasForeignKey(sl => sl.StudentId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<StudentFavLesson>()
                .HasOne(sl => sl.Lesson)
                .WithMany(l => l.StudentFavLessons)
                .HasForeignKey(sl => sl.LessonId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region StudentAchievement
            modelBuilder.Entity<StudentAchievement>()
                .HasKey(sa => sa.Id);
            modelBuilder.Entity<StudentAchievement>()
                .Property(sa => sa.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<StudentAchievement>()
                .Property(sa => sa.StudentId)
                .IsRequired();
            modelBuilder.Entity<StudentAchievement>()
                .Property(sa => sa.AchievementId)
                .IsRequired();
            modelBuilder.Entity<StudentAchievement>()
                .HasOne(sa => sa.Student)
                .WithMany(s => s.StudentAchievements)
                .HasForeignKey(sa => sa.StudentId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<StudentAchievement>()
                .HasOne(sa => sa.Achievement)
                .WithMany(a => a.StudentAchievements)
                .HasForeignKey(sa => sa.AchievementId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region Lesson
            modelBuilder.Entity<Lesson>()
                .HasKey(l => l.Id);
            modelBuilder.Entity<Lesson>()
                .Property(l => l.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Lesson>()
                .Property(l => l.Name)
                .IsRequired()
                .HasMaxLength(250);
            modelBuilder.Entity<Lesson>()
                .Property(l => l.Icon)
                .IsRequired()
                .HasMaxLength(250);
            modelBuilder.Entity<Lesson>()
                .Property(l => l.Grade)
                .IsRequired();
            modelBuilder.Entity<Lesson>()
                .HasMany(l => l.Attendances)
                .WithOne(a => a.Lesson)
                .HasForeignKey(a => a.LessonId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Lesson>()
                .HasMany(l => l.StudentFavLessons)
                .WithOne(sl => sl.Lesson)
                .HasForeignKey(sl => sl.LessonId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region Publisher
            modelBuilder.Entity<Publisher>()
                .HasKey(p => p.Id);
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Name)
                .IsRequired()
                .HasMaxLength(250);
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Email)
                .IsRequired()
                .HasMaxLength(250);
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Password)
                .IsRequired()
                .HasMaxLength(250);
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Address)
                .IsRequired(false)
                .HasMaxLength(250);
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Logo)
                .IsRequired(false)
                .HasMaxLength(250);
            modelBuilder.Entity<Publisher>()
                .Property(p => p.Website)
                .IsRequired(false)
                .HasMaxLength(250);
            #endregion

            #region Subjects
            modelBuilder.Entity<Subject>()
                .HasKey(s => s.Id);
            modelBuilder.Entity<Subject>()
                .Property(s => s.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Subject>()
                .Property(s => s.Name)
                .IsRequired()
                .HasMaxLength(250);
            modelBuilder.Entity<Subject>()
                .Property(s => s.Grade)
                .IsRequired();
            modelBuilder.Entity<Subject>()
                .Property(s => s.LessonId)
                .IsRequired();
            modelBuilder.Entity<Subject>()
                .HasOne(s => s.Lesson)
                .WithMany(l => l.Subjects)
                .HasForeignKey(s => s.LessonId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region Quizzes
            modelBuilder.Entity<Quiz>()
                .HasKey(q => q.Id);
            modelBuilder.Entity<Quiz>()
                .Property(q => q.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Quiz>()
                .Property(q => q.SubjectId)
                .IsRequired();
            modelBuilder.Entity<Quiz>()
                .Property(q => q.PublisherId)
                .IsRequired();
            modelBuilder.Entity<Quiz>()
                .HasOne(q => q.Publisher)
                .WithMany(p => p.Quizzes)
                .HasForeignKey(q => q.PublisherId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Quiz>()
                .HasOne(q => q.Subject)
                .WithMany(s => s.Quizzes)
                .HasForeignKey(q => q.SubjectId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region Questions
            modelBuilder.Entity<Question>()
                .HasKey(q => q.Id);
            modelBuilder.Entity<Question>()
                .Property(q => q.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Question>()
                .Property(q => q.QuizId)
                .IsRequired();
            modelBuilder.Entity<Question>()
                .Property(q => q.QuestionContent)
                .IsRequired()
                .HasColumnType("nvarchar(MAX)");
            modelBuilder.Entity<Question>()
                .Property(q => q.QuestionImage)
                .IsRequired(false)
                .HasMaxLength(250);
            modelBuilder.Entity<Question>()
                .Property(q => q.IsActive)
                .IsRequired()
                .HasDefaultValue(true);
            modelBuilder.Entity<Question>()
                .HasOne(q => q.Quiz)
                .WithMany(q => q.Questions)
                .HasForeignKey(q => q.QuizId)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<Question>()
                .HasMany(q => q.Choices)
                .WithOne(c => c.Question)
                .HasForeignKey(c => c.QuestionId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion

            #region Choices
            modelBuilder.Entity<Choice>()
                .HasKey(c => c.Id);
            modelBuilder.Entity<Choice>()
                .Property(c => c.Id)
                .ValueGeneratedOnAdd();
            modelBuilder.Entity<Choice>()
                .Property(c => c.QuestionId)
                .IsRequired();
            modelBuilder.Entity<Choice>()
                .Property(c => c.OptionContent)
                .IsRequired()
                .HasColumnType("nvarchar(MAX)");
            modelBuilder.Entity<Choice>()
                .Property(c => c.IsCorrect)
                .IsRequired()
                .HasDefaultValue(false);
            modelBuilder.Entity<Choice>()
                .Property(c => c.IsActive)
                .IsRequired()
                .HasDefaultValue(true);
            modelBuilder.Entity<Choice>()
                .HasOne(c => c.Question)
                .WithMany(q => q.Choices)
                .HasForeignKey(c => c.QuestionId)
                .OnDelete(DeleteBehavior.Restrict);
            #endregion
        }
    }
}
