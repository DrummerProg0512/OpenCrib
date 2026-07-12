using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class AreaLocationRelationInsertResponse : BaseResponse
    {
        public int NewAreaLocationRelationID { get; set; }
        public AreaLocationRelationInsertRequest? OriginalRequest { get; set; }
    }
}
