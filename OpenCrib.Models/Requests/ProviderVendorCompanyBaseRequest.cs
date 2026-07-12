using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class ProviderVendorCompanyBaseRequest
    {
        [Required]
        [StringLength(250)]
        public string VendorName { get; set; } = string.Empty;
        [StringLength(1000)]
        public string? VendorAddress { get; set; }
        [StringLength(50)]
        public string? VendorPhone { get; set; }
        [StringLength(250)]
        public string? VendorEmail { get; set; }
        [Required]
        public bool VendorActive { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}