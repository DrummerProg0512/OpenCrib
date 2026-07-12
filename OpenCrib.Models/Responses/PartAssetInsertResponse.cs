using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartAssetInsertResponse : BaseResponse
    {
        public long NewAssetID { get; set; }
        public PartAssetInsertRequest? OriginalRequest { get; set; }
    }
}