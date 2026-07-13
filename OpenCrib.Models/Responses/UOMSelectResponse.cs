using System.Collections.Generic;
using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public class UOMSelectResponse : BaseResponse
    {
        public List<UOM> UOMs { get; set; } = new();
    }
}