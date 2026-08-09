using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class UserBaseRequest
    {
        [Required]
        [StringLength(150)]
        public string? Username { get; set; }

        [StringLength(150)]
        public string? UserLastName { get; set; }

        [StringLength(50)]
        public string? UserCode { get; set; }

        [StringLength(500)]
        public string? EncPassword { get; set; }

        [StringLength(250)]
        public string? UserEmail { get; set; }

        [Required]
        [Range(1, int.MaxValue)]
        public int UserRoleID { get; set; }

        [Required]
        [Range(1, int.MaxValue)]
        public int UserTypeID { get; set; }

        public bool UserActive { get; set; } = true;
    }
}