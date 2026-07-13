using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class TransactionPartUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionPartID { get; set; }
        [Range(1, int.MaxValue)]
        public int? TransactionID { get; set; }
        [Range(1, int.MaxValue)]
        public int? PartID { get; set; }
        public decimal? Quantity { get; set; }
        public decimal? UnitCost { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}