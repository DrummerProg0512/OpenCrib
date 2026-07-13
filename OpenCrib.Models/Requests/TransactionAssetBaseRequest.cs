using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class TransactionAssetBaseRequest
    {
        [Required]
        [Range(1, long.MaxValue)]
        public long AssetID { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionID { get; set; }
        [Required]
        public int Quantity { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}