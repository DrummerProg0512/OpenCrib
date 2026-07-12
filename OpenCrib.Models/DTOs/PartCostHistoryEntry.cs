namespace OpenCrib.Models.DTOs
{
    public sealed class PartCostHistoryEntry
    {
        public int PartCostHistoryID { get; set; }
        public int PartID { get; set; }
        public decimal CostAmount { get; set; }
        public int CurrencyCodeID { get; set; }
        public decimal ExchangeRate { get; set; }
        public DateTime ExchangeRateDate { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}