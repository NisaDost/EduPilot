namespace EduPilot.Api.Data.Models
{
    public class ClaimedCoupon
    {
        public Guid Id { get; set; }
        public Guid StudentId { get; set; }
        public Guid CouponId { get; set; }
        public string Code { get; set; }
        public bool IsUsed { get; set; }
        public DateTime ClaimedDate { get; set; }
        public DateTime ExpirationDate { get; set; }
        public Student Student { get; set; }
        public Coupon Coupon { get; set; }
    }
}
