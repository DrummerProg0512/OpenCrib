using System.Collections.Generic;
using OpenCrib.Models.DTOs;

namespace OpenCrib.Models.Responses
{
    public class UserSelectResponse : BaseResponse
    {
        public List<User> Users { get; set; } = new();
    }
}