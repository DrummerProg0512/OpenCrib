using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartAssetSelectResponse : BaseResponse
    {
        public List<PartAsset> Assets { get; set; } = new List<PartAsset>();
    }
}