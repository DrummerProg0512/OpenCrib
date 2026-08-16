namespace OpenCrib.Models.Requests
{
    public sealed class CurrencyCodeSelectRequest
    {
        public int? CurrencyCodeID { get; set; }
        public string? CountryName { get; set; }
        public string? CurrencyName { get; set; }
        public string? CurrencyCode { get; set; }
        public bool? IsDefaultCurrency { get; set; }
        // Stored procedure expects YYYY-MM-DD HH:mm:ss strings
        public string? UpdatedOnStartDate { get; set; }
        public string? UpdatedOnEndDate { get; set; }
    }
}