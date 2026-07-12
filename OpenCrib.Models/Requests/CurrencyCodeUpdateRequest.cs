using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class CurrencyCodeUpdateRequest
    {
        [Required(ErrorMessage = "Currency code ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Currency code ID must be greater than 0.")]
        public int CurrencyCodeID { get; set; }

        [StringLength(10, ErrorMessage = "Currency code cannot exceed 10 characters.")]
        public string? CurrencyCodeValue { get; set; }

        [StringLength(250, ErrorMessage = "Currency name cannot exceed 250 characters.")]
        public string? CurrencyName { get; set; }

        [StringLength(10, ErrorMessage = "Currency symbol cannot exceed 10 characters.")]
        public string? CurrencySymbol { get; set; }

        public bool? CurrencyActive { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0 when provided.")]
        public int? UpdatedBy { get; set; }
    }
}