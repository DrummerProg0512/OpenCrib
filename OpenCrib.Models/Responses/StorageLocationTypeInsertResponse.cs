using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class StorageLocationTypeInsertResponse : BaseResponse
    {
        public int NewStorageLocationTypeID { get; set; }
        public StorageLocationTypeInsertRequest? OriginalRequest { get; set; }
    }
}