using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionStatusInsertResponse : BaseResponse
    {
        public int NewTransactionStatusID { get; set; }
        public TransactionStatusInsertRequest? OriginalRequest { get; set; }
    }
}