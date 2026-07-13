using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public class UserRoleInsertResponse : BaseResponse
    {
        public int NewRoleID { get; set; }
        public UserRoleInsertRequest? OriginalRequest { get; set; }
    }
}