using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class TransactionPartBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionID { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int PartID { get; set; }
        [Required]
        public decimal Quantity { get; set; }
        [Required]
        public decimal UnitCost { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}