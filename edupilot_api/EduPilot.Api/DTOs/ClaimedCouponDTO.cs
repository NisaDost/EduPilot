namespace EduPilot.Api.DTOs
{
    public class ClaimedCouponDTO
    {
        public Guid Id { get; set; }
        public string CouponName { get; set; }
        public string CouponIcon { get; set; }
        public string CouponDescription { get; set; }
        public string Code { get; set; }
        public bool IsUsed { get; set; }
        public DateTime ClaimedDate { get; set; }
        public DateTime ExpirationDate { get; set; }
    }
}
