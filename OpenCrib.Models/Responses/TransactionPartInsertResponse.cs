using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionPartInsertResponse : BaseResponse
    {
        public int NewTransactionPartID { get; set; }
        public TransactionPartInsertRequest? OriginalRequest { get; set; }
    }
}