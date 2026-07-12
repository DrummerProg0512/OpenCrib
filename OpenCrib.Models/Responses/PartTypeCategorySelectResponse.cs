using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartTypeCategorySelectResponse : BaseResponse
    {
        public List<PartTypeCategory> Categories { get; set; } = new List<PartTypeCategory>();
    }
}