using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class TransactionHistoryUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionHistoryID { get; set; }

        [Range(1, int.MaxValue)]
        public int? TransactionID { get; set; }

        public int? StatusID { get; set; }

        [StringLength(2000)]
        public string? Notes { get; set; }

        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}