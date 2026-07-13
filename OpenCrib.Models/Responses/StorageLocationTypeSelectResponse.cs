using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class StorageLocationTypeSelectResponse : BaseResponse
    {
        public List<StorageLocationType> Types { get; set; } = new List<StorageLocationType>();
    }
}