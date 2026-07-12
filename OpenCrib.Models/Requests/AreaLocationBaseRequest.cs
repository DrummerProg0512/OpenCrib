using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class AreaLocationBaseRequest
    {
        [Required(ErrorMessage = "Area location type ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area Location Type ID must be greater than 0.")]
        public int AreaLocationTypeID { get; set; }

        [Required(ErrorMessage = "Area location name is required.")]
        [StringLength(250, ErrorMessage = "Area Location Name cannot exceed 250 characters.")]
        public string AreaLocationName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Area location code is required.")]
        [StringLength(150, ErrorMessage = "Area Location Code cannot exceed 150 characters.")]
        public string AreaLocationCode { get; set; } = string.Empty;

        [StringLength(500, ErrorMessage = "Area Location Description cannot exceed 500 characters.")]
        public string? AreaLocationDescription { get; set; }

        [Required(ErrorMessage = "Area location active status is required.")]
        public bool AreaLocationActive { get; set; }

        [Required(ErrorMessage = "Updated by user ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Updated By user ID must be greater than 0.")]
        public int UpdatedBy { get; set; }
    }
}