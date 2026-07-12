using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartItemsAttachmentSelectResponse : BaseResponse
    {
        public List<PartItemsAttachment> Attachments { get; set; } = new List<PartItemsAttachment>();
    }
}