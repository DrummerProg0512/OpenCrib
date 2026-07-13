using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class TransactionStatusHistoryUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionStatusHistoryID { get; set; }
        public int? TransactionID { get; set; }
        public int? StatusID { get; set; }
        [StringLength(2000)]
        public string? Notes { get; set; }
        public int? UpdatedBy { get; set; }
    }
}