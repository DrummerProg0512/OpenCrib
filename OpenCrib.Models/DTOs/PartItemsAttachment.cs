namespace OpenCrib.Models.DTOs
{
    public sealed class PartItemsAttachment
    {
        public int PartsItemsAttachmentID { get; set; }
        public int PartID { get; set; }
        public byte[] ImageData { get; set; } = Array.Empty<byte>();
        public string FileName { get; set; } = string.Empty;
        public string FileDescription { get; set; } = string.Empty;
        public string FileType { get; set; } = string.Empty;
        public string MimeType { get; set; } = string.Empty;
        public int FileSize { get; set; }
        public bool ImageActive { get; set; }
        public DateTime UploadedOn { get; set; }
        public int UploadedBy { get; set; }
        public string? UploadedByUserName { get; set; }
    }
}