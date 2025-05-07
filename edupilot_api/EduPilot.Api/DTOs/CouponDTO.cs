namespace EduPilot.Api.DTOs
{
    public class CouponDTO
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Icon { get; set; }
        public int Fee { get; set; }
    }
}
