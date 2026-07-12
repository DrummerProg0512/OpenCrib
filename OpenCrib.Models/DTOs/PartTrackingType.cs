namespace OpenCrib.Models.DTOs
{
    public sealed class PartTrackingType
    {
        public int PartTrackingTypeID { get; set; }
        public string TrackingTypeName { get; set; } = string.Empty;
        public bool TrackingTypeActive { get; set; }
    }
}