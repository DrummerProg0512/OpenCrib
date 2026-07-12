namespace OpenCrib.Models.DTOs
{
    public sealed class ProviderVendorCompany
    {
        public int VendorID { get; set; }
        public string VendorName { get; set; } = string.Empty;
        public string? VendorAddress { get; set; }
        public string? VendorPhone { get; set; }
        public string? VendorEmail { get; set; }
        public bool VendorActive { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}