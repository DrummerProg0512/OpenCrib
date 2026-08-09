namespace OpenCrib.Models.DTOs
{
    public sealed class UserTypes
    {
        public int UserTypeID { get; set; }
        public string UserTypeName { get; set; } = string.Empty;
        public int CostApprovalLevel { get; set; }
        public decimal CostApprovalAmount { get; set; }
        public bool IsActive { get; set; }
    }
}
