namespace OpenCrib.Models.DTOs
{
    public sealed class TransactionStatusHistoryEntry
    {
        public int TransactionStatusHistoryID { get; set; }
        public int TransactionID { get; set; }
        public int StatusID { get; set; }
        public string? Notes { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}