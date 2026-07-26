using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class UserTypesBaseRequest
    {
        [Required(ErrorMessage = "User type name is required.")]
        [StringLength(255, ErrorMessage = "User type name cannot exceed 255 characters.")]
        public string UserTypeName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Cost approval level is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Cost approval level must be greater than 0.")]
        public int CostApprovalLevel { get; set; }

        [Required(ErrorMessage = "Cost approval amount is required.")]
        [Range(typeof(decimal), "0", "999999999999999999", ErrorMessage = "Cost approval amount must be non-negative.")]
        public decimal CostApprovalAmount { get; set; }

        public bool IsActive { get; set; } = true;
    }
}
