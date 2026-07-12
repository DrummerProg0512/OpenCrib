using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartUsageTypeInsertResponse : BaseResponse
    {
        public int NewPartUsageTypeID { get; set; }
        public PartUsageTypeInsertRequest? OriginalRequest { get; set; }
    }
}