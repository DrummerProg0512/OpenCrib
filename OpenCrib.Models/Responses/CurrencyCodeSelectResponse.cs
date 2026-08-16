using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class CurrencyCodeSelectResponse : BaseResponse
    {
        public List<CurrencyCodeDTO> Codes { get; set; } = new List<CurrencyCodeDTO>();
    }
}