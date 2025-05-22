using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using EduPilot.Api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/institution")]
    [ApiController]
    [Authorize]
    public class InstitutionsController : ControllerBase
    {
        private readonly ApiDbContext _context;
        private readonly BlobService _blobService;

        public InstitutionsController(ApiDbContext context, BlobService blobService)
        {
            _context = context;
            _blobService = blobService;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<InstitutionDTO>> GetInstitutionById(Guid id)
        {
            var sasToken = _blobService.GetAccountSasToken();

            var institution = await _context.Institutions
                .Select(i => new InstitutionDTO()
                {
                    Id = i.Id,
                    Name = i.Name,
                    Email = i.Email,
                    Address = i.Address,
                    Logo = string.IsNullOrWhiteSpace(i.Logo) ? string.Empty : $"{i.Logo}?{sasToken}",
                    Website = i.Website,
                })
                .FirstOrDefaultAsync(x => x.Id == id);
            if (institution == null)
            {
                return NotFound();
            }
            return institution;
        }

        [HttpPost("register")]
        public async Task<IActionResult> PostInstitution([FromBody] InstitutionRegisterDTO institution)
        {
            if (ModelState.IsValid)
            {
                if (await _context.Students.AnyAsync(s => s.Email == institution.Email))
                {
                    ModelState.AddModelError("Email", "Bu e-posta adresi zaten kayıtlı.");
                    return BadRequest(ModelState);
                }

                var institutionEntity = new Institution()
                {
                    Name = institution.Name,
                    Email = institution.Email,
                    Password = institution.Password,
                    Address = institution.Address,
                    Logo = institution.Logo,
                    Website = institution.Website,
                };

                _context.Institutions.Add(institutionEntity);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(PostInstitution), new { status = 201, id = institutionEntity.Id });
            }

            return BadRequest(ModelState);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutInstitution(Guid id, [FromForm] InstitutionRegisterDTO institution)
        {
            var institutionEntity = await _context.Institutions.FindAsync(id);
            if (institutionEntity == null)
            {
                return NotFound("Institution not found");
            }
            if (institutionEntity.Password == institution.Password)
            {
                if (!string.IsNullOrWhiteSpace(institution.Name))
                {
                    institutionEntity.Name = institution.Name;
                }
                institutionEntity.Address = institution.Address;
                institutionEntity.Website = institution.Website;
                if (!string.IsNullOrWhiteSpace(institution.NewPassword))
                {
                    institutionEntity.Password = institution.NewPassword;
                }
                if (institution.File != null)
                {
                    if (!string.IsNullOrWhiteSpace(institutionEntity.Logo))
                    {
                        await _blobService.DeleteFileAsync(institutionEntity.Logo);
                    }

                    string fileUrl = await _blobService.UploadInstitutionLogoFileAsync(institution.File, institutionEntity.Id);
                    institutionEntity.Logo = fileUrl;
                }
                _context.Institutions.Update(institutionEntity);
                await _context.SaveChangesAsync();
                return Ok();
            }
            return BadRequest("Mevcut parola doğru değil.");
        }

        [HttpGet("{id}/students")]
        public async Task<ActionResult<List<InstitutionStudentDTO>>> GetStudentsByInstitution(Guid id)
        {
            var students = await _context.Students
                                          .Where(s => s.InstitutionId == id)
                                          .Select(s => new InstitutionStudentDTO()
                                          {
                                              StudentId = s.Id,
                                              FirstName = s.FirstName,
                                              MiddleName = s.MiddleName,
                                              LastName = s.LastName,
                                              Grade = s.Grade,
                                              Email = s.Email,
                                              Mugshot = s.Mugshot,
                                              SupervisorName = s.StudentSupervisors
                                                                .Select(ss => ss.Supervisor.FirstName +
                                                                              (!string.IsNullOrEmpty(ss.Supervisor.MiddleName)
                                                                              ? " " + ss.Supervisor.MiddleName
                                                                              : "") +
                                                                              " " + ss.Supervisor.LastName)
                                                                .ToList(),
                                          })
                                          .ToListAsync();
            if (students == null || students.Count == 0)
            {
                return new List<InstitutionStudentDTO>();
            }
            return students;
        }

        [HttpPost("{id}/student/{email}")]
        public async Task<IActionResult> AddStudentToInstitution(Guid id, string email)
        {
            var institution = await _context.Institutions.FindAsync(id);
            if (institution == null)
            {
                return NotFound("Institution not found");
            }
            var student = await _context.Students.Where(s => s.Email == email).FirstAsync();
            if (student == null)
            {
                return NotFound("Student not found");
            }
            student.InstitutionId = id;
            _context.Students.Update(student);
            await _context.SaveChangesAsync();
            return Ok("Student added to institution");
        }

        [HttpDelete("{id}/student/{studentId}")]
        public async Task<IActionResult> RemoveStudentFromInstitution(Guid id, Guid studentId)
        {
            var institution = await _context.Institutions.FindAsync(id);
            if (institution == null)
            {
                return NotFound("Institution not found");
            }
            var student = await _context.Students.FindAsync(studentId);
            if (student == null)
            {
                return NotFound("Student not found");
            }
            student.InstitutionId = null;
            _context.Students.Update(student);
            await _context.SaveChangesAsync();
            return Ok("Student removed from institution");
        }

        [HttpGet("{id}/supervisor")]
        public async Task<ActionResult<List<InstitutionSupervisorDTO>>> GetSupervisorsByInstitution(Guid id)
        {
            var supervisors = await _context.Supervisors
                                            .Where(s => s.InstitutionId == id)
                                            .Select(s => new InstitutionSupervisorDTO()
                                            {
                                                SupervisorId = s.Id,
                                                FirstName = s.FirstName,
                                                MiddleName = s.MiddleName,
                                                LastName = s.LastName,
                                                Email = s.Email,
                                            })
                                            .ToListAsync();
            if (supervisors == null || supervisors.Count == 0)
            {
                return new List<InstitutionSupervisorDTO>();
            }
            return supervisors;
        }


        [HttpGet("{id}/attendance")]
        public async Task<ActionResult<List<InstitutionAttendanceDTO>>> GetAttendanceByInstitution(Guid id)
        {
            var attendances = await _context.Attendances
                                            .Where(a => a.InstitutionId == id)
                                            .Include(a => a.Student)
                                            .Include(a => a.Lesson)
                                            .Select(a => new InstitutionAttendanceDTO()
                                            {
                                                AttendanceId = a.Id,
                                                StudentId = a.StudentId,
                                                StudentName = a.Student.FirstName + " " + a.Student.MiddleName != String.Empty ? a.Student.MiddleName + " " + a.Student.LastName : a.Student.LastName,
                                                StudentGrade = a.Student.Grade,
                                                LessonId = a.LessonId,
                                                LessonName = a.Lesson.Name,
                                                Date = a.Date,
                                                IsPresent = a.IsPresent,
                                                Emotion = a.Emotion,
                                            })
                                            .ToListAsync();
            if (attendances == null || attendances.Count == 0)
            {
                return new List<InstitutionAttendanceDTO>();
            }
            return attendances;
        }

        [HttpPost("{id}/supervisor/{email}")]
        public async Task<IActionResult> AddSupervisorToInstitution(Guid id, String email)
        {
            var institution = await _context.Institutions.FindAsync(id);
            if (institution == null)
            {
                return NotFound("Institution not found");
            }
            var supervisor = await _context.Supervisors.FirstOrDefaultAsync(s => s.Email == email);
            if (supervisor == null)
            {
                return NotFound("Supervisor not found");
            }
            supervisor.InstitutionId = id;
            _context.Supervisors.Update(supervisor);
            await _context.SaveChangesAsync();
            return Ok("Supervisor added to institution");
        }

        [HttpDelete("{id}/supervisor/{supervisorId}")]
        public async Task<IActionResult> RemoveSupervisorFromInstitution(Guid id, Guid supervisorId)
        {
            var institution = await _context.Institutions.FindAsync(id);
            if (institution == null)
            {
                return NotFound("Institution not found");
            }
            var supervisor = await _context.Supervisors.FindAsync(supervisorId);
            if (supervisor == null)
            {
                return NotFound("Supervisor not found");
            }
            supervisor.InstitutionId = null;
            _context.Supervisors.Update(supervisor);
            await _context.SaveChangesAsync();
            return Ok("Supervisor removed from institution");
        }
    }
}
