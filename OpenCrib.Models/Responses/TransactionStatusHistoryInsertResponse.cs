using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public class TransactionStatusHistoryInsertResponse : BaseResponse
    {
        public int NewTransactionStatusHistoryID { get; set; }
        public TransactionStatusHistoryInsertRequest? OriginalRequest { get; set; }
    }
}