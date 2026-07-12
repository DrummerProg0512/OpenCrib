using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartCostHistoryUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartCostHistoryID { get; set; }
        [Range(1, int.MaxValue)]
        public int? PartID { get; set; }
        public decimal? CostAmount { get; set; }
        [Range(1, int.MaxValue)]
        public int? CurrencyCodeID { get; set; }
        public decimal? ExchangeRate { get; set; }
        public DateTime? ExchangeRateDate { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }    }
}