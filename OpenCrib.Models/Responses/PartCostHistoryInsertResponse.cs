using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartCostHistoryInsertResponse : BaseResponse
    {
        public int NewPartCostHistoryID { get; set; }
        public PartCostHistoryInsertRequest? OriginalRequest { get; set; }
    }
}