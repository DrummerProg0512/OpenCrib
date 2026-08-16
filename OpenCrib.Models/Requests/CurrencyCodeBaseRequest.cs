using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class CurrencyCodeBaseRequest
    {
        [StringLength(250, ErrorMessage = "Country name cannot exceed 250 characters.")]
        public string? CountryName { get; set; }

        [Required(ErrorMessage = "Currency name is required.")]
        [StringLength(150, ErrorMessage = "Currency name cannot exceed 150 characters.")]
        public string CurrencyName { get; set; } = string.Empty;

        [Required(ErrorMessage = "Currency code is required.")]
        [StringLength(20, ErrorMessage = "Currency code cannot exceed 20 characters.")]
        public string CurrencyCode { get; set; } = string.Empty;

        [Required(ErrorMessage = "IsDefaultCurrency is required.")]
        public bool IsDefaultCurrency { get; set; }

        [Required(ErrorMessage = "Updated by user ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0.")]
        public int UpdatedBy { get; set; }
    }
}