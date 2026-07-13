using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class TransactionStatusUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int TransactionStatusID { get; set; }

        [StringLength(250)]
        public string? StatusName { get; set; }

        [StringLength(1000)]
        public string? StatusDescription { get; set; }

        public bool? StatusActive { get; set; }
    }
}