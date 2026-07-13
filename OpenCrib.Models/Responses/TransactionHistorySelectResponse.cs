using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class TransactionHistorySelectResponse : BaseResponse
    {
        public List<TransactionHistoryEntry> Entries { get; set; } = new List<TransactionHistoryEntry>();
    }
}