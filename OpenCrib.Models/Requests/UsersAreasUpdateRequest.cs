using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UsersAreasUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int UsersAreasID { get; set; }

        [Range(1, int.MaxValue)]
        public int? AreaLocationID { get; set; }

        [Range(1, int.MaxValue)]
        public int? UserID { get; set; }

        [StringLength(27)]
        public string? UpdatedOnString { get; set; }

        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }

        public bool? UsersAreaActive { get; set; }
    }
}
