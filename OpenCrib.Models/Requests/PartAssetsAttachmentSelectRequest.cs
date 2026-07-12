namespace OpenCrib.Models.Requests
{
    public sealed class PartAssetsAttachmentSelectRequest
    {
        public int? PartAssetsAttachmentID { get; set; }
        public long? AssetID { get; set; }
        public string? FileName { get; set; }
        public bool? ImageActive { get; set; }
        public int? UploadedBy { get; set; }
        public DateTime? UploadedOnStart { get; set; }
        public DateTime? UploadedOnEnd { get; set; }
    }
}