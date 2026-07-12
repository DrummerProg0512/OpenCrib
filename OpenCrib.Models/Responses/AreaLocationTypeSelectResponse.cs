using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class AreaLocationTypeSelectResponse : BaseResponse
    {
        public List<AreaLocationType> Types { get; set; } = new List<AreaLocationType>();
    }
}