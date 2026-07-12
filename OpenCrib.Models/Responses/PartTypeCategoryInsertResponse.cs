using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartTypeCategoryInsertResponse : BaseResponse
    {
        public int NewPartTypeCategoryID { get; set; }
        public PartTypeCategoryInsertRequest? OriginalRequest { get; set; }
    }
}