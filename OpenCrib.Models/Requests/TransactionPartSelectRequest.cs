namespace OpenCrib.Models.Requests
{
    public sealed class TransactionPartSelectRequest
    {
        public int? TransactionPartID { get; set; }
        public int? TransactionID { get; set; }
        public int? PartID { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
        public int? UpdatedBy { get; set; }
    }
}