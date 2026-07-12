namespace OpenCrib.Models.Requests
{
    public sealed class PartItemsAttachmentSelectRequest
    {
        public int? PartsItemsAttachmentID { get; set; }
        public int? PartID { get; set; }
        public string? FileName { get; set; }
        public bool? ImageActive { get; set; }
        public int? UploadedBy { get; set; }
        public DateTime? UploadedOnStart { get; set; }
        public DateTime? UploadedOnEnd { get; set; }
    }
}