using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Services.ICRUD
{
    public interface ICRUD_PartAssets
    {
        Task<PartAssetInsertResponse> PartAssetInsert(PartAssetInsertRequest request);
        Task<PartAssetSelectResponse> PartAssetSearch(PartAssetSelectRequest request);
        Task<PartAssetUpdateResponse> PartAssetUpdate(PartAssetUpdateRequest request);
    }
}
