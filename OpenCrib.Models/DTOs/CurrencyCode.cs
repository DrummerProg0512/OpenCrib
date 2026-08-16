namespace OpenCrib.Models.DTOs
{
    public sealed class CurrencyCodeDTO
    {
        public int CurrencyCodeID { get; set; }
        public string CountryName { get; set; } = string.Empty;
        public string CurrencyName { get; set; } = string.Empty;
        public string CurrencyCode { get; set; } = string.Empty;
        public bool IsDefaultCurrency { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}}