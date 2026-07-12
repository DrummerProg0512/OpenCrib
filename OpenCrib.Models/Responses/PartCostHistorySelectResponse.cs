using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartCostHistorySelectResponse : BaseResponse
    {
        public List<PartCostHistoryEntry> Entries { get; set; } = new List<PartCostHistoryEntry>();
    }
}