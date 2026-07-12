using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartStorageLocationSelectResponse : BaseResponse
    {
        public List<PartStorageLocation> Locations { get; set; } = new List<PartStorageLocation>();
    }
}