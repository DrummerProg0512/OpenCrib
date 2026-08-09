using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class UserTypeSelectResponse : BaseResponse
    {
        public List<UserTypes> UserTypesResult { get; set; } = new List<UserTypes>();
    }
}
