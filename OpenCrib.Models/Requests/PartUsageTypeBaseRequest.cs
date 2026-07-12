using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartUsageTypeBaseRequest
    {
        [Required]
        [StringLength(250)]
        public string UsageTypeName { get; set; } = string.Empty;
        [StringLength(500)]
        public string? UsageTypeDescription { get; set; }
        [Required]
        public bool UsageTypeActive { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}