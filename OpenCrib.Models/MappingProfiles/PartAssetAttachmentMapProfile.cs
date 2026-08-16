using AutoMapper;
using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Models.MappingProfiles
{
    public sealed class PartAssetAttachmentMapProfile : Profile
    {
        public PartAssetAttachmentMapProfile()
        {
            CreateMap<PartAssetsAttachmentInsertRequest, PartAssetsAttachmentInsertResponse>()
                .ForMember(dest => dest.IsSuccessful, opt => opt.Ignore())
                .ForMember(dest => dest.exMessage, opt => opt.Ignore())
                .ForMember(dest => dest.NewPartAssetsAttachmentID, opt => opt.Ignore())
                .ForMember(dest => dest.OriginalRequest, opt => opt.MapFrom(src => src));
        }
    }
}
