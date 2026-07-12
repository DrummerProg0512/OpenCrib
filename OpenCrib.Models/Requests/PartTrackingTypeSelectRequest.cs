namespace OpenCrib.Models.Requests
{
    public sealed class PartTrackingTypeSelectRequest
    {
        public int? PartTrackingTypeID { get; set; }
        public string? TrackingTypeName { get; set; }
        public bool? TrackingTypeActive { get; set; }
    }
}