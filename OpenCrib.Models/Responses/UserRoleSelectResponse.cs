using System.Collections.Generic;
using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public class UserRoleSelectResponse : BaseResponse
    {
        public List<UserRole> UserRoles { get; set; } = new();
    }
}