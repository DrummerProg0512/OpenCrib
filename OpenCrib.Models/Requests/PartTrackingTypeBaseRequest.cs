using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartTrackingTypeBaseRequest
    {
        [Required]
        [StringLength(250)]
        public string TrackingTypeName { get; set; } = string.Empty;
        [Required]
        public bool TrackingTypeActive { get; set; }
    }
}