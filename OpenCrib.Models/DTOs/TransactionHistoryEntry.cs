namespace OpenCrib.Models.DTOs
{
    public sealed class TransactionHistoryEntry
    {
        public int TransactionHistoryID { get; set; }
        public int TransactionID { get; set; }
        public int StatusID { get; set; }
        public string? Notes { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}