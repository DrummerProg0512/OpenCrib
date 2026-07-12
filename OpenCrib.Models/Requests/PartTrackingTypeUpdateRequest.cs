using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartTrackingTypeUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartTrackingTypeID { get; set; }
        [StringLength(250)]
        public string? TrackingTypeName { get; set; }
        public bool? TrackingTypeActive { get; set; }
    }
}