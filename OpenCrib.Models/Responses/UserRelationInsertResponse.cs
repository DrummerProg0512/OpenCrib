using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public class UserRelationInsertResponse : BaseResponse
    {
        public int NewUserRelationID { get; set; }
        public UserRelationInsertRequest? OriginalRequest { get; set; }
    }
}