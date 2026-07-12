using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class AreaLocationTypeBaseRequest
    {
        [Required(ErrorMessage = "Area location type name is required.")]
        [StringLength(250, ErrorMessage = "Name cannot exceed 250 characters.")]
        public string AreaLocationTypeName { get; set; } = string.Empty;

        [StringLength(500, ErrorMessage = "Description cannot exceed 500 characters.")]
        public string? AreaLocationTypeDescription { get; set; }

        [Required(ErrorMessage = "Active status is required.")]
        public bool AreaLocationTypeActive { get; set; }

        [Required(ErrorMessage = "Updated by user ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0.")]
        public int UpdatedBy { get; set; }
    }
}