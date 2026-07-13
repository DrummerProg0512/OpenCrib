using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class TransactionStatusBaseRequest
    {
        [Required]
        [StringLength(250)]
        public string StatusName { get; set; } = string.Empty;
        [StringLength(1000)]
        public string? StatusDescription { get; set; }
        [Required]
        public bool StatusActive { get; set; }
    }
}