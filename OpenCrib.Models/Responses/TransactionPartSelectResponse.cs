using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionPartSelectResponse : BaseResponse
    {
        public List<TransactionPart> Parts { get; set; } = new List<TransactionPart>();
    }
}