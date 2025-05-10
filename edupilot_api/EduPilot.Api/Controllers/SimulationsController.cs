using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using EduPilot.Api.DTOs;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/simulation")]
    [ApiController]
    [Authorize]
    public class SimulationsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public SimulationsController(ApiDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<SimulationDTO>>> GetSimulations()
        {
            var simulations = await _context.Simulations
                .Select(s => new SimulationDTO()
                {
                    Id = s.Id,
                    Name = s.Name,
                    StudyDuration = s.StudyDuration,
                    BreakDuration = s.BreakDuration,
                }).ToListAsync();

            if (simulations == null || !simulations.Any())
            {
                return NotFound("No simulations found.");
            }
            return Ok(simulations);
        }

        [HttpPost("{id}/student/{studentId}")]
        public async Task<ActionResult<StudentSimulation>> PostStudiedSimulation(Guid id, Guid studentId)
        {
            var simulation = await _context.Simulations.FindAsync(id);
            if (simulation == null)
            {
                return NotFound("Simulation not found.");
            }
            var student = await _context.Students.FindAsync(studentId);
            if (student == null)
            {
                return NotFound("Student not found.");
            }

            var studiedSimulation = new StudentSimulation
            {
                SimulationId = id,
                StudentId = studentId,
                StudiedAt = DateTime.UtcNow
            };

            var simCount = await _context.StudentSimulations.CountAsync((ss) => ss.StudentId == studentId);
            var newSimCount = simCount++;

            _context.StudentSimulations.Add(studiedSimulation);
            await _context.SaveChangesAsync();


            switch (newSimCount)
            {
                case 5:
                    // earn achievement
                    break;
                case 15:
                    // earn achievement
                    break;
                case 30:
                    // earn achievement
                    break;
                default:
                    break;
            }

            return CreatedAtAction(nameof(PostStudiedSimulation), new { status = 201, id = studiedSimulation.Id });
        }
    }
}
