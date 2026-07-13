using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class TransactionAssetUpdateRequest
    {
        [Required]
        [Range(1, long.MaxValue)]
        public long TransactionAssetID { get; set; }
        [Range(1, long.MaxValue)]
        public long? AssetID { get; set; }
        [Range(1, int.MaxValue)]
        public int? TransactionID { get; set; }
        public int? Quantity { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}