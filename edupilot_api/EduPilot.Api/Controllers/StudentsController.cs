using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using EduPilot.Api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/students")]
    [ApiController]
    public class StudentsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public StudentsController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<StudentDTO>> GetStudentById(Guid id)
        {
            var student = await _context.Students
                                        .Select(s => new StudentDTO()
                                        {
                                            StudentId = s.Id,
                                            FirstName = s.FirstName,
                                            MiddleName = s.MiddleName,
                                            LastName = s.LastName,
                                            Grade = s.Grade,
                                            Avatar = s.Avatar,
                                            DailyStreakCount = s.DailyStreakCount,
                                            Points = s.Points,
                                            InstitutionName = s.Institution != null ? s.Institution.Name : null,
                                            FavoriteLessons = s.StudentFavLessons.Select(sfl => new FavoriteLessonDTO()
                                            {
                                                LessonId = sfl.Lesson.Id,
                                                LessonName = sfl.Lesson.Name,
                                                LessonIcon = sfl.Lesson.Icon
                                            }).ToList(),
                                            StudentAchievements = s.StudentAchievements.Select(sa => new StudentAchievementDTO()
                                            {
                                                AchievementId = sa.Achievement.Id,
                                                AchievementName = sa.Achievement.Name,
                                                AchievementIcon = sa.Achievement.Icon,
                                                AchievementDescription = sa.Achievement.Description
                                            }).ToList(),
                                            StudentSupervisors = s.StudentSupervisors.Select(ss => new StudentSupervisorDTO()
                                            {
                                                SupervisorId = ss.Supervisor.Id,
                                                SupervisorName = ss.Supervisor.FirstName + " " + ss.Supervisor.LastName
                                            }).ToList()
                                        })
                                        .FirstOrDefaultAsync(x => x.StudentId == id);

            if (student == null)
            {
                return NotFound();
            }

            return student;
        }

        [HttpGet("{id}/supervisors")]
        public async Task<ActionResult<List<StudentSupervisorDTO>>> GetStudentSupervisors(Guid id)
        {
            var supervisors = await _context.Students
                                            .Where(s => s.Id == id)
                                            .SelectMany(s => s.StudentSupervisors)
                                            .Select(ss => new StudentSupervisorDTO()
                                            {
                                                SupervisorId = ss.Supervisor.Id,
                                                SupervisorName = ss.Supervisor.FirstName + " " + ss.Supervisor.LastName
                                            })
                                            .ToListAsync();

            if (supervisors == null || supervisors.Count == 0)
            {
                return NotFound();
            }

            return supervisors;
        }

        [HttpGet("{id}/achievements")]
        public async Task<ActionResult<List<StudentAchievementDTO>>> GetStudentAchievements(Guid id)
        {
            var achievements = await _context.Students
                                             .Where(s => s.Id == id)
                                             .SelectMany(s => s.StudentAchievements)
                                             .Select(sa => new StudentAchievementDTO()
                                             {
                                                 AchievementId = sa.Achievement.Id,
                                                 AchievementName = sa.Achievement.Name,
                                                 AchievementIcon = sa.Achievement.Icon,
                                                 AchievementDescription = sa.Achievement.Description
                                             })
                                             .ToListAsync();

            if (achievements == null || achievements.Count == 0)
            {
                return NotFound();
            }

            return achievements;
        }

        [HttpPut("{id}/favoritelessons")]
        public async Task<ActionResult> UpdateStudentFavoriteLessons(Guid id, [FromBody] List<Guid> lessonIds)
        {
            if (lessonIds == null || lessonIds.Count == 0)
            {
                ModelState.AddModelError("LessonIds", "En az bir favori ders seçilmelidir.");
                return BadRequest(ModelState);
            }

            var student = await _context.Students.Include(s => s.StudentFavLessons).FirstOrDefaultAsync(s => s.Id == id);
            if (student == null)
            {
                return NotFound();
            }

            student.StudentFavLessons.Clear();
            foreach (var lessonId in lessonIds)
            {
                var lesson = await _context.Lessons.FindAsync(lessonId);
                if (lesson != null)
                {
                    student.StudentFavLessons.Add(new StudentFavLesson()
                    {
                        Lesson = lesson
                    });
                }
            }

            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpPost("register")]
        public async Task<ActionResult> PostStudent(StudentRegisterDTO student)
        {
            if (ModelState.IsValid)
            {
                if (await _context.Students.AnyAsync(s => s.Email == student.Email))
                {
                    ModelState.AddModelError("Email", "Bu e-posta adresi zaten kayıtlı.");
                    return BadRequest(ModelState);
                }

                if (await _context.Students.AnyAsync(s => s.PhoneNumber == student.PhoneNumber))
                {
                    ModelState.AddModelError("PhoneNumber", "Bu telefon numarası zaten kayıtlı.");
                    return BadRequest(ModelState);
                }

                var supervisor = new Supervisor();
                if (string.IsNullOrWhiteSpace(student.SupervisorName) && string.IsNullOrWhiteSpace(student.SupervisorUniqueCode.ToString()))
                {
                    supervisor = await _context.Supervisors.FirstOrDefaultAsync(s => s.UniqueCode == student.SupervisorUniqueCode && s.FirstName == student.SupervisorName);
                    if (supervisor == null)
                    {
                        ModelState.AddModelError("SupervisorUniqueCode", "Danışman bulunamadı.");
                        return NotFound(ModelState);
                    }
                }

                var favLessons = await _context.Lessons.Where(x => student.FavoriteLessons.Contains(x.Id)).ToListAsync();

                var studentEntity = new Student()
                {
                    FirstName = student.FirstName,
                    MiddleName = student.MiddleName,
                    LastName = student.LastName,
                    Grade = student.Grade,
                    Email = student.Email,
                    Password = student.Password,
                    PhoneNumber = student.PhoneNumber,
                    Avatar = student.Avatar,
                    DailyStreakCount = 0,
                    Points = 0,
                    StudentFavLessons = new List<StudentFavLesson>(),
                    StudentAchievements = new List<StudentAchievement>(),
                    StudentSupervisors = new List<StudentSupervisor>()
                };

                foreach (var lesson in favLessons)
                {
                    studentEntity.StudentFavLessons.Add(new StudentFavLesson()
                    {
                        Lesson = lesson
                    });
                }

                if (supervisor != null)
                {
                    studentEntity.StudentSupervisors.Add(new StudentSupervisor()
                    {
                        Supervisor = supervisor
                    });
                }

                _context.Students.Add(studentEntity);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(PostStudent), new { id = studentEntity.Id });
            }

            return BadRequest(ModelState);
        }

        [HttpPost("{id}/supervisor")]
        public async Task<ActionResult> PostStudentSupervisor(Guid id, [FromBody]AddStudentSupervisorDTO supervisorDTO)
        {
            if (supervisorDTO.SupervisorName == null || supervisorDTO.SupervisorUniqueCode == 0)
            {
                ModelState.AddModelError("Supervisor", "Danışman adı ve benzersiz kodu gereklidir.");
                return BadRequest(ModelState);
            }

            var student = await _context.Students.FindAsync(id);
            if (student == null)
            {
                return NotFound();
            }

            var supervisor = await _context.Supervisors.FirstOrDefaultAsync(s => s.FirstName.Equals(supervisorDTO.SupervisorName) && s.UniqueCode.Equals(supervisorDTO.SupervisorUniqueCode));
            if (supervisor == null)
            {
                return NotFound();
            }

            var studentSupervisor = new StudentSupervisor()
            {
                Student = student,
                Supervisor = supervisor
            };

            _context.StudentSupervisors.Add(studentSupervisor);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(PostStudentSupervisor), new { id = student.Id });
        }

        [HttpDelete("{id}/supervisor/{supervisorId}")]
        public async Task<ActionResult> DeleteStudentSupervisor(Guid id, Guid supervisorId)
        {
            var student = await _context.Students.Include(s => s.StudentSupervisors).FirstOrDefaultAsync(s => s.Id == id);
            if (student == null)
            {
                return NotFound();
            }

            var studentSupervisor = student.StudentSupervisors.FirstOrDefault(ss => ss.SupervisorId == supervisorId);
            if (studentSupervisor == null)
            {
                return NotFound();
            }

            _context.StudentSupervisors.Remove(studentSupervisor);
            await _context.SaveChangesAsync();
            
            return NoContent();
        }
    }
}
