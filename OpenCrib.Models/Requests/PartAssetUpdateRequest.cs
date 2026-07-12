using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartAssetUpdateRequest
    {
        [Required(ErrorMessage = "Asset ID is required.")]
        [Range(1, long.MaxValue, ErrorMessage = "Asset ID must be greater than 0.")]
        public long AssetID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Part ID must be greater than 0 when provided.")]
        public int? PartID { get; set; }

        [StringLength(100, ErrorMessage = "Serial number cannot exceed 100 characters.")]
        public string? SerialNumber { get; set; }

        [StringLength(1024, ErrorMessage = "Asset tag cannot exceed 1024 characters.")]
        public string? AssetTag { get; set; }

        public int? AssetStatusID { get; set; }
        public DateTime? PurchaseDate { get; set; }
        public DateTime? WarrantyExpiration { get; set; }
        public DateTime? LastCalibrationDate { get; set; }
        public DateTime? NextCalibrationDate { get; set; }

        public int? AssetCondiftion { get; set; }
        public bool? IsActive { get; set; }
        [Range(1, int.MaxValue, ErrorMessage = "UpdatedBy must be greater than 0 when provided.")]
        public int? UpdatedBy { get; set; }
    }
}