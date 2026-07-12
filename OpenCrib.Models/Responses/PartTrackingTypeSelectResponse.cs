using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartTrackingTypeSelectResponse : BaseResponse
    {
        public List<PartTrackingType> Types { get; set; } = new List<PartTrackingType>();
    }
}