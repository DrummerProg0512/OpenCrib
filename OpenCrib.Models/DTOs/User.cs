using System;

namespace OpenCrib.Models.DTOs
{
    public class User
    {
        public int UserID { get; set; }
        public string? UserName { get; set; }
        public string? UserLastName { get; set; }
        public string? UserCode { get; set; }
        public string? EncPassword { get; set; }
        public string? UserEmail { get; set; }
        public bool UserActive { get; set; }
        public int UserRoleID { get; set; }
        public int UserRoleIDRef { get; set; }
        public string? UserRoleName { get; set; }
        public string? UserRoleCode { get; set; }
        public int UserTypeID { get; set; }
        public int UserTypeIDRef { get; set; }
        public string? UserTypeName { get; set; }
        public int CostApprovalLevel { get; set; }
        public decimal CostApprovalAmount { get; set; }
        public bool UserTypeIsActive { get; set; }
    }
}