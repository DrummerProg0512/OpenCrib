using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class AreaLocationRelationSelectResponse : BaseResponse
    {
        public List<AreaLocationRelation> Relations { get; set; } = [];
    }
}
