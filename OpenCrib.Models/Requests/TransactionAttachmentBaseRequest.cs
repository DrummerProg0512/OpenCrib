using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class TransactionAttachmentBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionID { get; set; }
        [Required]
        public byte[] FileData { get; set; } = Array.Empty<byte>();
        [Required]
        [StringLength(255)]
        public string FileName { get; set; } = string.Empty;
        [StringLength(500)]
        public string? FileDescription { get; set; }
        [StringLength(100)]
        public string? MimeType { get; set; }
        public int FileSize { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UploadedBy { get; set; }
    }
}