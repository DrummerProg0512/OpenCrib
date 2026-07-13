using System.Collections.Generic;
using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public class TransactionStatusHistorySelectResponse : BaseResponse
    {
        public List<TransactionStatusHistoryEntry> TransactionStatusHistory { get; set; } = new();
    }
}