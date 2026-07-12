using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class ProviderVendorCompanyUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int VendorID { get; set; }
        [StringLength(250)]
        public string? VendorName { get; set; }
        [StringLength(1000)]
        public string? VendorAddress { get; set; }
        [StringLength(50)]
        public string? VendorPhone { get; set; }
        [StringLength(250)]
        public string? VendorEmail { get; set; }
        public bool? VendorActive { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}