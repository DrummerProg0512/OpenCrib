using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public class UserInsertResponse : BaseResponse
    {
        public int NewUserID { get; set; }
        public UserInsertRequest? OriginalRequest { get; set; }
    }
}