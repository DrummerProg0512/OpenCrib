using OpenCrib.Models.Requests;

namespace OpenCrib.Models.Responses
{
    public sealed class PartItemsAttachmentInsertResponse : BaseResponse
    {
        public int NewPartsItemsAttachmentID { get; set; }
        public PartItemsAttachmentInsertRequest? OriginalRequest { get; set; }
    }
}