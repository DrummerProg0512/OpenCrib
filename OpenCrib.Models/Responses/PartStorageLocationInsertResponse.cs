using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartStorageLocationInsertResponse : BaseResponse
    {
        public int NewPartStorageLocationID { get; set; }
        public PartStorageLocationInsertRequest? OriginalRequest { get; set; }
    }
}