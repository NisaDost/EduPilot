using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Linq;

namespace EduPilot.Api.Controllers
{
    [Route("api/supervisors")]
    [ApiController]
    [Authorize]
    public class SupervisorsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public SupervisorsController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<SupervisorDTO>> GetSupervisor(Guid id)
        {
            var supervisor = await _context.Supervisors
                .Where(s => s.Id == id)
                .Include(s => s.StudentSupervisors)
                .Select(s => new SupervisorDTO
                {
                    Id = id,
                    InstitutionId = s.InstitutionId,
                    StudentIds = s.StudentSupervisors.Where(ss => ss.SupervisorId == id).Select(ss => ss.StudentId).ToList(),
                    FirstName = s.FirstName,
                    MiddleName = s.MiddleName,
                    LastName = s.LastName,
                    Email = s.Email,
                    PhoneNumber = s.PhoneNumber,
                    UniqueCode = s.UniqueCode,
                })
                .FirstOrDefaultAsync();

            if (supervisor == null)
            {
                return NotFound();
            }

            return Ok(supervisor);
        }

        [HttpPost("register")]
        public async Task<ActionResult<SupervisorRegisterDTO>> PostSupervisor([FromBody] SupervisorRegisterDTO supervisorDTO)
        {
            if (ModelState.IsValid)
            {
                if (await _context.Supervisors.AnyAsync(s => s.Email == supervisorDTO.Email))
                {
                    ModelState.AddModelError("Email", "Bu e-posta adresi zaten kayıtlı.");
                    return BadRequest(ModelState);
                }

                if (await _context.Supervisors.AnyAsync(s => s.PhoneNumber == supervisorDTO.PhoneNumber))
                {
                    ModelState.AddModelError("PhoneNumber", "Bu telefon numarası zaten kayıtlı.");
                    return BadRequest(ModelState);
                }

                int uniqueCode;
                do
                {
                    uniqueCode = GenerateReadableCode(8);
                } while (await _context.Supervisors.AnyAsync(s => s.UniqueCode == uniqueCode));

                var supervisor = new Supervisor
                {
                    FirstName = supervisorDTO.FirstName,
                    MiddleName = supervisorDTO.MiddleName,
                    LastName = supervisorDTO.LastName,
                    Email = supervisorDTO.Email,
                    Password = supervisorDTO.Password,
                    PhoneNumber = supervisorDTO.PhoneNumber,
                    UniqueCode = uniqueCode
                };

                _context.Supervisors.Add(supervisor);
                await _context.SaveChangesAsync();

                return Ok();
            }

            return BadRequest();
        }

        private static int GenerateReadableCode(int length)
        {
            const string chars = "1234567890"; // only int values
            var random = new Random();
            var generated = new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());

            // Fix for CS1501 and CS1002: Correctly parse the generated string to an integer and return it.  
            if (int.TryParse(generated, out int result))
            {
                return result;
            }
            throw new InvalidOperationException("Failed to generate a valid integer.");
        }

        [HttpGet("{id}/info/")]
        public async Task<ActionResult<SupervisorInfoDTO>> GetSupervisorInfo(Guid id)
        {
            var supervisorInfo = await _context.Supervisors
                .Where(s => s.Id == id)
                .Include(s => s.StudentSupervisors)
                .ThenInclude(ss => ss.Student)
                .Select(s => new SupervisorInfoDTO
                {
                    Students = s.StudentSupervisors.Select(ss => new SupervisorStudentsInfoDTO
                    {
                        StudentId = ss.Student.Id,
                        StudentFirstName = ss.Student.FirstName,
                        StudentMiddleName = ss.Student.MiddleName,
                        StudentLastName = ss.Student.LastName,
                        StudentGrade = ss.Student.Grade
                    }).ToList(),
                    InstitutionId = s.InstitutionId,
                    InstitutionName = s.Institution.Name
                })
                .FirstOrDefaultAsync();

            if (supervisorInfo == null)
            {
                return NotFound();
            }

            return Ok(supervisorInfo);
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSupervisor(Guid id)
        {
            var supervisor = await _context.Supervisors.FindAsync(id);
            if (supervisor == null)
            {
                return NotFound();
            }

            _context.Supervisors.Remove(supervisor);
            await _context.SaveChangesAsync();

            return NoContent();
        }
    }
}
