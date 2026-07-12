using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartTypeCategoryUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartTypeCategoryID { get; set; }
        [StringLength(250)]
        public string? CategoryName { get; set; }
        [StringLength(1000)]
        public string? CategoryDescription { get; set; }
        public bool? CategoryActive { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}