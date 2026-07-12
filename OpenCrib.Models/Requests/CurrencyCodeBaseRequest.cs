using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class CurrencyCodeBaseRequest
    {
        [Required(ErrorMessage = "Currency code value is required.")]
        [StringLength(10, ErrorMessage = "Currency code cannot exceed 10 characters.")]
        public string CurrencyCodeValue { get; set; } = string.Empty;

        [StringLength(250, ErrorMessage = "Currency name cannot exceed 250 characters.")]
        public string? CurrencyName { get; set; }

        [StringLength(10, ErrorMessage = "Currency symbol cannot exceed 10 characters.")]
        public string? CurrencySymbol { get; set; }

        [Required(ErrorMessage = "Active status is required.")]
        public bool CurrencyActive { get; set; }

        [Required(ErrorMessage = "Updated by user ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0.")]
        public int UpdatedBy { get; set; }
    }
}