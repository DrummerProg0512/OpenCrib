namespace OpenCrib.Models.Requests
{
    public sealed class PartAssetSelectRequest
    {
        public long? AssetID { get; set; }
        public int? PartID { get; set; }
        public string? SerialNumber { get; set; }
        public string? AssetTag { get; set; }
        public int? AssetStatusID { get; set; }
        public bool? IsActive { get; set; }
        public int? UpdatedBy { get; set; }

        public DateTime? UpdatedOnStartDate { get; set; }
        public DateTime? UpdatedOnEndDate { get; set; }
    }
}