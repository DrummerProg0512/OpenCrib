using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class CurrencyCodeSelectResponse : BaseResponse
    {
        public List<CurrencyCode> Codes { get; set; } = new List<CurrencyCode>();
    }
}