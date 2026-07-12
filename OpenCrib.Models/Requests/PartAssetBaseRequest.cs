using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartAssetBaseRequest
    {
        [Required(ErrorMessage = "Part ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Part ID must be greater than 0.")]
        public int PartID { get; set; }

        [StringLength(100, ErrorMessage = "Serial number cannot exceed 100 characters.")]
        public string? SerialNumber { get; set; }

        [StringLength(1024, ErrorMessage = "Asset tag cannot exceed 1024 characters.")]
        public string? AssetTag { get; set; }

        [Required(ErrorMessage = "Asset status ID is required.")]
        public int AssetStatusID { get; set; }

        public DateTime? PurchaseDate { get; set; }
        public DateTime? WarrantyExpiration { get; set; }
        public DateTime? LastCalibrationDate { get; set; }
        public DateTime? NextCalibrationDate { get; set; }

        [Required(ErrorMessage = "Asset condition is required.")]
        public int AssetCondiftion { get; set; }

        [Required(ErrorMessage = "IsActive flag is required.")]
        public bool IsActive { get; set; }

        [Required(ErrorMessage = "UpdatedBy is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "UpdatedBy must be greater than 0.")]
        public int UpdatedBy { get; set; }
    }
}