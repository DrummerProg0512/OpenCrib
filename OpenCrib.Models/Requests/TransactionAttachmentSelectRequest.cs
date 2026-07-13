namespace OpenCrib.Models.Requests
{
    public sealed class TransactionAttachmentSelectRequest
    {
        public int? TransactionAttachmentID { get; set; }
        public int? TransactionID { get; set; }
        public string? FileName { get; set; }
        public int? UploadedBy { get; set; }
        public DateTime? UploadedOnStart { get; set; }
        public DateTime? UploadedOnEnd { get; set; }
    }
}