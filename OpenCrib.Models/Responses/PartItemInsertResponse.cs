using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartItemInsertResponse : BaseResponse
    {
        public int NewPartID { get; set; }
        public PartItemInsertRequest? OriginalRequest { get; set; }
    }
}