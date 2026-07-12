namespace OpenCrib.Models.Requests
{
    public sealed class AreaLocationSelectRequest
    {
        public int? AreaLocationID { get; set; }
        public int? AreaLocationTypeID { get; set; }
        public string? AreaLocationName { get; set; }
        public string? AreaLocationCode { get; set; }
        public string? AreaLocationDescription { get; set; }
        public bool? AreaLocationActive { get; set; }
        public int? UserID { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}