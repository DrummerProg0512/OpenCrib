using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class AreaLocationInsertResponse : BaseResponse
    {
        public int NewAreaLocationID { get; set; }
        public AreaLocationInsertRequest? OriginalRequest { get; set; }
    }
}