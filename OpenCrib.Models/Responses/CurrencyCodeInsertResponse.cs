using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class CurrencyCodeInsertResponse : BaseResponse
    {
        public int NewCurrencyCodeID { get; set; }
        public CurrencyCodeInsertRequest? OriginalRequest { get; set; }
    }
}