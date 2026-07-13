using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionAttachmentInsertResponse : BaseResponse
    {
        public int NewTransactionAttachmentID { get; set; }
        public TransactionAttachmentInsertRequest? OriginalRequest { get; set; }
    }
}