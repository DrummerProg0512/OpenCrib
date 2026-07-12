namespace OpenCrib.Models.DTOs
{
    public sealed class PartAsset
    {
        public long AssetID { get; set; }
        public int PartID { get; set; }
        public string SerialNumber { get; set; } = string.Empty;
        public string AssetTag { get; set; } = string.Empty;
        public int AssetStatusID { get; set; }
        public DateTime? PurchaseDate { get; set; }
        public DateTime? WarrantyExpiration { get; set; }
        public DateTime? LastCalibrationDate { get; set; }
        public DateTime? NextCalibrationDate { get; set; }
        public int AssetCondiftion { get; set; }
        public bool IsActive { get; set; }
        public int UpdatedBy { get; set; }
        public string? UpdatedByUserName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}