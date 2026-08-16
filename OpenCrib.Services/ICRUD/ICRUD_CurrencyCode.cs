using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Services.ICRUD
{
    internal interface ICRUD_CurrencyCode
    {
        Task<CurrencyCodeInsertResponse> CurrencyCodeInsert(CurrencyCodeInsertRequest request);
        Task<CurrencyCodeSelectResponse> CurrencyCodeSearch(CurrencyCodeSelectRequest request);
        Task<CurrencyCodeUpdateResponse> CurrencyCodeUpdate(CurrencyCodeUpdateRequest request);
    }
}
