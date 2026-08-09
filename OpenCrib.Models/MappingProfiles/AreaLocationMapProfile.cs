using AutoMapper;
using System;
using System.Collections.Generic;
using System.Text;
using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Models.MappingProfiles
{
    public sealed class AreaLocationMapProfile : Profile
    {
        public AreaLocationMapProfile()
        {
            CreateMap<AreaLocationInsertRequest, AreaLocationInsertResponse>()
                .ForMember(dest => dest.IsSuccessful, opt => opt.Ignore())
                .ForMember(dest => dest.exMessage, opt => opt.Ignore())
                .ForMember(dest => dest.OriginalRequest, opt => opt.MapFrom(src => src));
        }
    }
}
