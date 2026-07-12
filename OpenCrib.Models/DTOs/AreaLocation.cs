namespace OpenCrib.Models.DTOs
{
    public sealed class AreaLocation
    {
        public int AreaLocationID { get; set; }
        public int AreaLocationTypeID { get; set; }
        public string? AreaLocationTypeName { get; set; }
        public string? AreaLocationName { get; set; }
        public string? AreaLocationCode { get; set; }
        public string? AreaLocationDescription { get; set; }
        public bool AreaLocationActive { get; set; }
        public int UpdatedBy { get; set; }
        public string? UpdatedByUserName { get; set; }
        public string? UpdatedByUserLastName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}