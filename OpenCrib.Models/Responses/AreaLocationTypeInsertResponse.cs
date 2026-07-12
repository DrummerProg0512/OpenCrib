using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class AreaLocationTypeInsertResponse : BaseResponse
    {
        public int NewAreaLocationTypeID { get; set; }
        public AreaLocationTypeInsertRequest? OriginalRequest { get; set; }
    }
}