using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class UsersAreasBaseRequests
    {
        [Required(ErrorMessage = "Area Location ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area Location ID must be greater than 0.")]
        public int AreaLocationID { get; set; }

        [Required(ErrorMessage = "User ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "User ID must be greater than 0.")]
        public int UserID { get; set; }

        [StringLength(27, ErrorMessage = "Updated On String cannot exceed 27 characters.")]
        public string? UpdatedOnString { get; set; }

        [Required(ErrorMessage = "Updated By is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Updated By must be greater than 0.")]
        public int UpdatedBy { get; set; }

        [Required(ErrorMessage = "Users Area Active is required.")]
        public bool UsersAreaActive { get; set; } = true;
    }
}
