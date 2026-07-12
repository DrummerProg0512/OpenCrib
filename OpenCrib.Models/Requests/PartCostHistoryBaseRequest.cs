using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartCostHistoryBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartID { get; set; }
        [Required]
        public decimal CostAmount { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int CurrencyCodeID { get; set; }
        [Required]
        public decimal ExchangeRate { get; set; }
        [Required]
        public DateTime ExchangeRateDate { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }    }
}