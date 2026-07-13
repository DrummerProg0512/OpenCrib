using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionStatusSelectResponse : BaseResponse
    {
        public List<TransactionStatus> Statuses { get; set; } = new List<TransactionStatus>();
    }
}