using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UserRelationUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int UserRelationID { get; set; }
        public int? UserID { get; set; }
        public int? RelatedUserID { get; set; }
        [StringLength(200)]
        public string? RelationType { get; set; }
        [StringLength(2000)]
        public string? Notes { get; set; }
        public int? UpdatedBy { get; set; }
    }
}