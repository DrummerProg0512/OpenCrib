using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UserRoleUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int RoleID { get; set; }
        [StringLength(200)]
        public string? Name { get; set; }
        [StringLength(2000)]
        public string? Description { get; set; }
        public int? UpdatedBy { get; set; }
    }
}