namespace OpenCrib.Models.DTOs
{
    public sealed class PartUsageType
    {
        public int PartUsageTypeID { get; set; }
        public string UsageTypeName { get; set; } = string.Empty;
        public string? UsageTypeDescription { get; set; }
        public bool UsageTypeActive { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}