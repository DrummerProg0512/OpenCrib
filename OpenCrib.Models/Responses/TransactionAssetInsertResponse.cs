using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionAssetInsertResponse : BaseResponse
    {
        public long NewTransactionAssetID { get; set; }
        public TransactionAssetInsertRequest? OriginalRequest { get; set; }
    }
}