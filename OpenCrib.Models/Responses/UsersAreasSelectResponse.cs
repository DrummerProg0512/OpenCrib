using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class UsersAreasSelectResponse : BaseResponse
    {
        public List<UsersAreas> UsersAreasResult { get; set; } = new List<UsersAreas>();
    }
}
