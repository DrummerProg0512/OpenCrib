namespace OpenCrib.Models.Requests
{
    public sealed class CurrencyCodeSelectRequest
    {
        public int? CurrencyCodeID { get; set; }
        public string? CurrencyCodeValue { get; set; }
        public string? CurrencyName { get; set; }
        public bool? CurrencyActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}