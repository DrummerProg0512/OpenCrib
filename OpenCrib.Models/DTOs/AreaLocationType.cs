namespace OpenCrib.Models.DTOs
{
    public sealed class AreaLocationType
    {
        public int AreaLocationTypeID { get; set; }
        public string AreaLocationTypeName { get; set; } = string.Empty;
        public string? AreaLocationTypeDescription { get; set; }
        public bool AreaLocationTypeActive { get; set; }
        public int UpdatedBy { get; set; }
        public string? UpdatedByUserName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}