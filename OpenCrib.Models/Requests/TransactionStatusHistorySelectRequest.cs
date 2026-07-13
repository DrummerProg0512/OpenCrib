namespace OpenCrib.Models.Requests
{
    public sealed class TransactionStatusHistorySelectRequest
    {
        public int? TransactionStatusHistoryID { get; set; }
        public int? TransactionID { get; set; }
        public int? StatusID { get; set; }
        public int? UpdatedBy { get; set; }
    }
}