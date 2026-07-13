using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class TransactionAttachmentUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionAttachmentID { get; set; }
        [Range(1, int.MaxValue)]
        public int? TransactionID { get; set; }
        public byte[]? FileData { get; set; }
        [StringLength(255)]
        public string? FileName { get; set; }
        [StringLength(500)]
        public string? FileDescription { get; set; }
        [StringLength(100)]
        public string? MimeType { get; set; }
        public int? FileSize { get; set; }
        [Range(1, int.MaxValue)]
        public int? UploadedBy { get; set; }    }
}