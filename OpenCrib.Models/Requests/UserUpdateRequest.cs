using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UserUpdateRequest : UserBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int UserID { get; set; }

        [StringLength(150)]
        public string? UserName { get; set; }

        [StringLength(150)]
        public new string? UserLastName { get; set; }

        [StringLength(50)]
        public new string? UserCode { get; set; }

        [StringLength(500)]
        public new string? EncPassword { get; set; }

        [StringLength(250)]
        public new string? UserEmail { get; set; }

        [Range(1, int.MaxValue)]
        public new int? UserRoleID { get; set; }

        [Range(1, int.MaxValue)]
        public new int? UserTypeID { get; set; }

        public new bool? UserActive { get; set; }
    }
}