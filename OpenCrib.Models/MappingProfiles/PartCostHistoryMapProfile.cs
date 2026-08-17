using AutoMapper;
using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Models.MappingProfiles
{
    public sealed class PartCostHistoryMapProfile : Profile
    {
        public PartCostHistoryMapProfile()
        {
            CreateMap<PartCostHistoryInsertRequest, PartCostHistoryInsertResponse>()
                .ForMember(dest => dest.IsSuccessful, opt => opt.Ignore())
                .ForMember(dest => dest.exMessage, opt => opt.Ignore())
                .ForMember(dest => dest.NewPartCostHistoryID, opt => opt.Ignore())
                .ForMember(dest => dest.OriginalRequest, opt => opt.MapFrom(src => src));
        }
    }
}
