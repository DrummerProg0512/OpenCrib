using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class ProviderVendorCompanySelectResponse : BaseResponse
    {
        public List<ProviderVendorCompany> Companies { get; set; } = new List<ProviderVendorCompany>();
    }
}