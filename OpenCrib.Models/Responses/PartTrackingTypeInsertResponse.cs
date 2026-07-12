using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartTrackingTypeInsertResponse : BaseResponse
    {
        public int NewPartTrackingTypeID { get; set; }
        public PartTrackingTypeInsertRequest? OriginalRequest { get; set; }
    }
}