namespace EduPilot.Api.Data.Models
{
    public class Coupon
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Icon { get; set; }
        public int Fee { get; set; }
        public bool IsAvailable { get; set; }
        public List<ClaimedCoupon> ClaimedCoupons { get; set; }
    }
}