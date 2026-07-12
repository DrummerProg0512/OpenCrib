namespace OpenCrib.Models.Requests
{
    public sealed class PartUsageTypeSelectRequest
    {
        public int? PartUsageTypeID { get; set; }
        public string? UsageTypeName { get; set; }
        public bool? UsageTypeActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}