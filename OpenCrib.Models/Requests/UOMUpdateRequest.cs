using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UOMUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int UOMID { get; set; }
        [StringLength(200)]
        public string? Name { get; set; }
        [StringLength(50)]
        public string? Abbreviation { get; set; }
        [StringLength(2000)]
        public string? Description { get; set; }
        public int? UpdatedBy { get; set; }
    }
}