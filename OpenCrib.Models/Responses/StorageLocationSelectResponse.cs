using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class StorageLocationSelectResponse : BaseResponse
    {
        public List<StorageLocation> Locations { get; set; } = new List<StorageLocation>();
    }
}