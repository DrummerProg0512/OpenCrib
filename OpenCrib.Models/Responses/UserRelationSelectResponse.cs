using System.Collections.Generic;
using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public class UserRelationSelectResponse : BaseResponse
    {
        public List<UserRelation> UserRelations { get; set; } = new();
    }
}