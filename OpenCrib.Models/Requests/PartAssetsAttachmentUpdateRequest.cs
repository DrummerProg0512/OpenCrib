using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartAssetsAttachmentUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartAssetsAttachmentID { get; set; }
        [Range(1, long.MaxValue)]
        public long? AssetID { get; set; }
        public byte[]? ImageData { get; set; }
        [StringLength(255)]
        public string? FileName { get; set; }
        [StringLength(500)]
        public string? FileDescription { get; set; }
        [StringLength(10)]
        public string? FileType { get; set; }
        [StringLength(50)]
        public string? MimeType { get; set; }
        public int? FileSize { get; set; }
        public bool? ImageActive { get; set; }
        [Range(1, int.MaxValue)]
        public int? UploadedBy { get; set; }    }
}