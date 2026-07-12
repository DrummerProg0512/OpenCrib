using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartUsageTypeSelectResponse : BaseResponse
    {
        public List<PartUsageType> Types { get; set; } = new List<PartUsageType>();
    }
}