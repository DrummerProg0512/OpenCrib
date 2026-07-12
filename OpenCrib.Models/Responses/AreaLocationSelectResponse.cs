using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class AreaLocationSelectResponse : BaseResponse
    {
        public List<AreaLocation> Locations { get; set; } = new List<AreaLocation>();
    }
}