using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public class UserInsertResponse : BaseResponse
    {
        public int UserID { get; set; }
        public UserInsertRequest? OriginalRequest { get; set; }
    }
}