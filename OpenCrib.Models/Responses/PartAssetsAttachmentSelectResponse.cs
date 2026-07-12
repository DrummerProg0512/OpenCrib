using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public sealed class PartAssetsAttachmentSelectResponse : BaseResponse
    {
        public List<PartAssetsAttachment> Attachments { get; set; } = new List<PartAssetsAttachment>();
    }
}