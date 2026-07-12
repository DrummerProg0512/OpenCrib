namespace OpenCrib.Models.Requests
{
    public sealed class AreaLocationTypeSelectRequest
    {
        public int? AreaLocationTypeID { get; set; }
        public string? AreaLocationTypeName { get; set; }
        public bool? AreaLocationTypeActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}