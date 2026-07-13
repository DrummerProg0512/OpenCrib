namespace OpenCrib.Models.DTOs
{
    public sealed class TransactionStatus
    {
        public int TransactionStatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
        public string? StatusDescription { get; set; }
        public bool StatusActive { get; set; }
    }
}