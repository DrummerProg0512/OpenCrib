namespace OpenCrib.Models.Requests
{
    public sealed class TransactionStatusSelectRequest
    {
        public int? TransactionStatusID { get; set; }
        public string? StatusName { get; set; }
        public bool? StatusActive { get; set; }
    }
}