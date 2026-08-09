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

        public bool? AreaLocationTypeActive { get; set; }
    }
}