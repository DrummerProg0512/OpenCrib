using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class ProviderVendorCompanyInsertResponse : BaseResponse
    {
        public int NewVendorID { get; set; }
        public ProviderVendorCompanyInsertRequest? OriginalRequest { get; set; }
    }
}