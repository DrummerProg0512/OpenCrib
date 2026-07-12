using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartItemsAttachmentBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartID { get; set; }
        [Required]
        public byte[] ImageData { get; set; } = Array.Empty<byte>();
        [Required]
        [StringLength(255)]
        public string FileName { get; set; } = string.Empty;
        [StringLength(500)]
        public string? FileDescription { get; set; }
        [StringLength(10)]
        public string? FileType { get; set; }
        [StringLength(50)]
        public string? MimeType { get; set; }
        public int FileSize { get; set; }
        [Required]
        public bool ImageActive { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UploadedBy { get; set; }    }
}