using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public class UOMInsertResponse : BaseResponse
    {
        public int NewUOMID { get; set; }
        public UOMInsertRequest? OriginalRequest { get; set; }
    }
}