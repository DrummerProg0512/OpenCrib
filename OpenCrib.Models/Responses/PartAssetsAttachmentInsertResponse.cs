using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartAssetsAttachmentInsertResponse : BaseResponse
    {
        public int NewPartAssetsAttachmentID { get; set; }
        public PartAssetsAttachmentInsertRequest? OriginalRequest { get; set; }
    }
}