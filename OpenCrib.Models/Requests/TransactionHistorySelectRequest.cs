namespace OpenCrib.Models.Requests
{
    public sealed class TransactionHistorySelectRequest
    {
        public int? TransactionHistoryID { get; set; }
        public int? TransactionID { get; set; }
        public int? StatusID { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}