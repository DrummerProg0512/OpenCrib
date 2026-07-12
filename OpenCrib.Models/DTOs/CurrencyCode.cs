namespace OpenCrib.Models.DTOs
{
    public sealed class CurrencyCode
    {
        public int CurrencyCodeID { get; set; }
        public string CurrencyCodeValue { get; set; } = string.Empty; // e.g., USD
        public string? CurrencyName { get; set; }
        public string? CurrencySymbol { get; set; }
        public bool CurrencyActive { get; set; }
        public int UpdatedBy { get; set; }
        public string? UpdatedByUserName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}