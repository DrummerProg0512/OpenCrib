using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UserUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int UserID { get; set; }
        [StringLength(200)]
        public string? Username { get; set; }
        [StringLength(200)]
        public string? FirstName { get; set; }
        [StringLength(200)]
        public string? LastName { get; set; }
        [StringLength(320)]
        public string? Email { get; set; }
        public bool? IsActive { get; set; }
        public int? UpdatedBy { get; set; }
    }
}