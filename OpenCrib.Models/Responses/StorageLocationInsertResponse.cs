using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class StorageLocationInsertResponse : BaseResponse
    {
        public int NewStorageLocationID { get; set; }
        public StorageLocationInsertRequest? OriginalRequest { get; set; }
    }
}