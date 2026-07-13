using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class UserRelationBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int UserID { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int RelatedUserID { get; set; }
        [StringLength(200)]
        public string? RelationType { get; set; }
        [StringLength(2000)]
        public string? Notes { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}