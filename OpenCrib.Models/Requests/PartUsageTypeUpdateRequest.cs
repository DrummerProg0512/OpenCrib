using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartUsageTypeUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartUsageTypeID { get; set; }
        [StringLength(250)]
        public string? UsageTypeName { get; set; }
        [StringLength(500)]
        public string? UsageTypeDescription { get; set; }
        public bool? UsageTypeActive { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}