using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Services.ICRUD
{
    public interface ICRUD_PartAssetAttachment
    {
        Task<PartAssetsAttachmentInsertResponse> PartAssetsAttachmentInsert(PartAssetsAttachmentInsertRequest request);
        Task<PartAssetsAttachmentSelectResponse> PartAssetsAttachmentSearch(PartAssetsAttachmentSelectRequest request);
        Task<PartAssetsAttachmentUpdateResponse> PartAssetsAttachmentUpdate(PartAssetsAttachmentUpdateRequest request);
    }
}
