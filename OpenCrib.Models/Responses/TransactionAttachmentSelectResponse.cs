using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionAttachmentSelectResponse : BaseResponse
    {
        public List<TransactionAttachment> Attachments { get; set; } = new List<TransactionAttachment>();
    }
}