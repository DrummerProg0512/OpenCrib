namespace OpenCrib.Models.Requests
{
    public sealed class ProviderVendorCompanySelectRequest
    {
        public int? VendorID { get; set; }
        public string? VendorName { get; set; }
        public bool? VendorActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}