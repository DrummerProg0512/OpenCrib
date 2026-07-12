using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class AreaLocationTypeUpdateRequest
    {
        [Required(ErrorMessage = "Area location type ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area location type ID must be greater than 0.")]
        public int AreaLocationTypeID { get; set; }

        [StringLength(250, ErrorMessage = "Name cannot exceed 250 characters.")]
        public string? AreaLocationTypeName { get; set; }

        [StringLength(500, ErrorMessage = "Description cannot exceed 500 characters.")]
        public string? AreaLocationTypeDescription { get; set; }

        public bool? AreaLocationTypeActive { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0 when provided.")]
        public int? UpdatedBy { get; set; }
    }
}