using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionAssetSelectResponse : BaseResponse
    {
        public List<TransactionAsset> Assets { get; set; } = new List<TransactionAsset>();
    }
}