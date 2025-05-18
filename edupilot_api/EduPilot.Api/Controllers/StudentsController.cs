using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using EduPilot.Api.Models;
using Humanizer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Linq;

namespace EduPilot.Api.Controllers
{
    [Route("api/students")]
    [ApiController]
    [Authorize]
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

        [HttpGet("{id}/favoritelessons")]
        public async Task<ActionResult<List<FavoriteLessonDTO>>> GetStudentFavoriteLessons(Guid id)
        {
            var favLessons = await _context.StudentFavLessons
                .Where(sfl => sfl.StudentId.Equals(id))
                .Select(fl => new FavoriteLessonDTO()
                {
                    LessonId = fl.LessonId,
                    LessonName = fl.Lesson.Name,
                    LessonIcon = fl.Lesson.Icon
                }).ToListAsync();

            return favLessons;
        }

        [HttpPut("{id}/favoritelessons")]
        public async Task<ActionResult> UpdateStudentFavoriteLessons(Guid id, [FromBody] UpdateFavoriteLessonsDTO updateFavoriteLessons)
        {
            if (updateFavoriteLessons == null || updateFavoriteLessons.LessonIds.Count == 0)
            {
                ModelState.AddModelError("LessonIds", "En az bir favori ders seçilmelidir.");
                return BadRequest(ModelState);
            }

            var student = await _context.Students.Include(s => s.StudentFavLessons).FirstOrDefaultAsync(s => s.Id == id);
            if (student == null)
            {
                return NotFound();
            }

            var studentFavLessons = await _context.StudentFavLessons.Where(sfl => sfl.StudentId.Equals(id)).ToListAsync();

            foreach (var studentFavLesson in studentFavLessons)
            {
                _context.StudentFavLessons.Remove(studentFavLesson);
            }
            await _context.SaveChangesAsync();

            foreach (var lessonId in updateFavoriteLessons.LessonIds)
            {
                var lesson = await _context.Lessons.FindAsync(lessonId);
                if (lesson != null)
                {
                    _context.StudentFavLessons.Add(new StudentFavLesson()
                    {
                        StudentId = student.Id,
                        LessonId = lesson.Id,
                        Lesson = lesson,
                        Student = student
                    });
                }
            }

            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpPut("{id}/avatar")]
        public async Task<ActionResult> UpdateStudentAvatar(Guid id, [FromBody] UpdateAvatarDTO updateAvatar)
        {
            var student = await _context.Students.FindAsync(id);
            if (student == null)
            {
                return NotFound();
            }
            student.Avatar = updateAvatar.Avatar;
            _context.Entry(student).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok();
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

                Supervisor? supervisor = null;
                if (!string.IsNullOrWhiteSpace(student.SupervisorName) && !string.IsNullOrWhiteSpace(student.SupervisorUniqueCode.ToString()))
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

                return CreatedAtAction(nameof(PostStudent), new { status = 201, id = studentEntity.Id });
            }

            return BadRequest(ModelState);
        }

        [HttpPost("{id}/supervisor")]
        public async Task<ActionResult> PostStudentSupervisor(Guid id, [FromBody] AddStudentSupervisorDTO supervisorDTO)
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

        [HttpGet("{id}/solvedquestioncount/{start}/{end}")]
        public async Task<ActionResult<List<SolvedQuestionCountDTO>>> GetSolvedQuestionCountPerWeek(Guid id, DateTime start, DateTime end)
        {
            var counts = await _context.SolvedQuestionCounts
                .Include(sqc => sqc.Lesson)
                .Where(sqc => sqc.StudentId == id)
                .ToListAsync();

            var studentQuestionCount = new List<SolvedQuestionCountDTO>();

            foreach (var count in counts)
            {
                var lesson = count.Lesson;
                if (lesson == null)
                {
                    continue;
                }

                var countEntity = new SolvedQuestionCountDTO()
                {
                    Id = count.Id,
                    StudentId = id,
                    LessonId = count.LessonId,
                    LessonName = lesson.Name,
                    Count = count.Count,
                    EntryDate = count.EntryDate,
                    StartOfWeek = start,
                    EndOfWeek = end,
                };

                if (countEntity.EntryDate <= countEntity.EndOfWeek && countEntity.EntryDate >= countEntity.StartOfWeek)
                {
                    studentQuestionCount.Add(countEntity);
                }
            }

            return studentQuestionCount;
        }

        [HttpGet("{id}/solvedquestioncount/{date}")]
        public async Task<ActionResult<List<SolvedQuestionCountDTO>>> GetSolvedQuestionCountPerWeek(Guid id, DateTime date)
        {
            var counts = await _context.SolvedQuestionCounts
                .Include(sqc => sqc.Lesson)
                .Where(sqc => sqc.StudentId == id)
                .ToListAsync();

            var studentQuestionCount = new List<SolvedQuestionCountDTO>();

            foreach (var count in counts)
            {
                var lesson = count.Lesson;
                if (lesson == null)
                {
                    continue;
                }

                var countEntity = new SolvedQuestionCountDTO()
                {
                    Id = count.Id,
                    StudentId = id,
                    LessonId = count.LessonId,
                    LessonName = lesson.Name,
                    Count = count.Count,
                    EntryDate = count.EntryDate,
                };

                if (countEntity.EntryDate.Date == date.Date)
                {
                    studentQuestionCount.Add(countEntity);
                }
            }

            return studentQuestionCount;
        }

        [HttpPost("{id}/add/questioncount/{count}/lesson/{lessonId}/date/{date}")]
        public async Task<ActionResult<SolvedQuestionCount>> PostSolvedQuestionCount(Guid id, int count, Guid lessonId, DateTime date)
        {
            var existingEntity = await _context.SolvedQuestionCounts.FirstOrDefaultAsync(sqc => sqc.LessonId == lessonId && sqc.EntryDate == date.Date);
            if (existingEntity == null)
            {
                var countEntity = new SolvedQuestionCount()
                {
                    StudentId = id,
                    LessonId = lessonId,
                    Count = count,
                    EntryDate = date.Date
                };
                _context.SolvedQuestionCounts.Add(countEntity);
            }
            else
            {
                existingEntity.Count += count;
                _context.SolvedQuestionCounts.Update(existingEntity);
            }
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpPut("{id}/mugshot")]
        public async Task<ActionResult> UpdateStudentMugShot(Guid id, [FromBody] UpdateMugshotDTO updateMugshot)
        {
            var student = await _context.Students.FindAsync(id);
            if (student == null)
            {
                return NotFound();
            }
            student.Mugshot = updateMugshot.Mugshot;
            _context.Entry(student).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return Ok();
        }

        [HttpGet("{id}/weaksubjects")]
        public async Task<ActionResult<List<WeakSubjectsDTO>>> GetWeakSubjects(Guid id)
        {
            var weakSubjects = await _context.WeakSubjects
                .Where(ws => ws.StudentId == id)
                .GroupBy(ws => new { ws.SubjectId, ws.SubjectName })
                .Where(g => g.Count() >= 5)
                .Select(g => new WeakSubjectsDTO
                {
                    StudentId = id,
                    SubjectId = g.Key.SubjectId,
                    SubjectName = g.Key.SubjectName
                })
                .ToListAsync();

            return Ok(weakSubjects);
        }
    }
}
