namespace OpenCrib.Models.DTOs
{
    public sealed class TransactionAttachment
    {
        public int TransactionAttachmentID { get; set; }
        public int TransactionID { get; set; }
        public byte[] FileData { get; set; } = Array.Empty<byte>();
        public string FileName { get; set; } = string.Empty;
        public string? FileDescription { get; set; }
        public string? MimeType { get; set; }
        public int FileSize { get; set; }
        public int UploadedBy { get; set; }
        public DateTime UploadedOn { get; set; }
    }
}