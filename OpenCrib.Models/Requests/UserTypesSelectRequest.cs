namespace OpenCrib.Models.Requests
{
    public sealed class UserTypesSelectRequest
    {
        public int? UserTypeID { get; set; }
        public string? UserTypeName { get; set; }
        public int? CostApprovalLevel { get; set; }
        public bool? IsActive { get; set; }
    }
}
