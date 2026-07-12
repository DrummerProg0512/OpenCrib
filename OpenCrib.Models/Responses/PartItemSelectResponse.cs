using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartItemSelectResponse : BaseResponse
    {
        public List<PartItem> Items { get; set; } = new List<PartItem>();
    }
}