using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionHistoryInsertResponse : BaseResponse
    {
        public int NewTransactionHistoryID { get; set; }
        public TransactionHistoryInsertRequest? OriginalRequest { get; set; }
    }
}