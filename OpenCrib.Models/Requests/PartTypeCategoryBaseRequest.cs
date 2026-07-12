using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartTypeCategoryBaseRequest
    {
        [Required]
        [StringLength(250)]
        public string CategoryName { get; set; } = string.Empty;
        [StringLength(1000)]
        public string? CategoryDescription { get; set; }
        [Required]
        public bool CategoryActive { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}