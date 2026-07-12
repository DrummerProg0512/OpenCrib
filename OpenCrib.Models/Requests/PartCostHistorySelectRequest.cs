namespace OpenCrib.Models.Requests
{
    public sealed class PartCostHistorySelectRequest
    {
        public int? PartCostHistoryID { get; set; }
        public int? PartID { get; set; }
        public int? CurrencyCodeID { get; set; }
        public DateTime? ExchangeRateDateStart { get; set; }
        public DateTime? ExchangeRateDateEnd { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}