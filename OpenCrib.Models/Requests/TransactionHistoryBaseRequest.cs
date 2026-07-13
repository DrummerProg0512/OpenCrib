using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class TransactionHistoryBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionID { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int StatusID { get; set; }
        [StringLength(2000)]
        public string? Notes { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}