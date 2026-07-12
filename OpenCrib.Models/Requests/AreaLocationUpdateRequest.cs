using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class AreaLocationUpdateRequest
    {
        [Required(ErrorMessage = "Area location ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area location ID must be greater than 0.")]
        public int AreaLocationID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Area Location Type ID must be greater than 0 when provided.")]
        public int? AreaLocationTypeID { get; set; }

        [StringLength(250, ErrorMessage = "Area Location Name cannot exceed 250 characters.")]
        public string? AreaLocationName { get; set; }

        [StringLength(150, ErrorMessage = "Area Location Code cannot exceed 150 characters.")]
        public string? AreaLocationCode { get; set; }

        [StringLength(500, ErrorMessage = "Area Location Description cannot exceed 500 characters.")]
        public string? AreaLocationDescription { get; set; }

        public bool? AreaLocationActive { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Updated By user ID must be greater than 0 when provided.")]
        public int? UpdatedBy { get; set; }
    }
}