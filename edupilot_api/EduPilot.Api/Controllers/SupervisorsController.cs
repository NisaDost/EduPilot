using EduPilot.Api.Data;
using EduPilot.Api.Data.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace EduPilot.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class SupervisorsController : ControllerBase
    {
        private readonly ApiDbContext _context;

        public SupervisorsController(ApiDbContext context)
        {
            _context = context;
        }

        // GET: api/Supervisors
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Supervisor>>> GetSupervisors()
        {
            return await _context.Supervisors.ToListAsync();
        }

        // GET: api/Supervisors/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Supervisor>> GetSupervisor(Guid id)
        {
            var supervisor = await _context.Supervisors.FindAsync(id);

            if (supervisor == null)
            {
                return NotFound();
            }

            return supervisor;
        }

        // PUT: api/Supervisors/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSupervisor(Guid id, Supervisor supervisor)
        {
            if (id != supervisor.Id)
            {
                return BadRequest();
            }

            _context.Entry(supervisor).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SupervisorExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Supervisors
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<Supervisor>> PostSupervisor(Supervisor supervisor)
        {
            _context.Supervisors.Add(supervisor);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetSupervisor", new { id = supervisor.Id }, supervisor);
        }

        // DELETE: api/Supervisors/5
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

        private bool SupervisorExists(Guid id)
        {
            return _context.Supervisors.Any(e => e.Id == id);
        }
    }
}
