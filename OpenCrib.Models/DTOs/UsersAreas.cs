using System;

namespace OpenCrib.Models.DTOs
{
    public sealed class UsersAreas
    {
        public int UsersAreasID { get; set; }
        public int AreaLocationID { get; set; }
        public int AreaLocationIDRef { get; set; }
        public string? AreaLocationName { get; set; }
        public int UserID { get; set; }
        public int UserIDRef { get; set; }
        public string? UserName { get; set; }
        public string? UserLastName { get; set; }
        public DateTime UpdatedOn { get; set; }
        public int UpdatedBy { get; set; }
        public int UpdatedByUserIDRef { get; set; }
        public string? UpdatedByUserName { get; set; }
        public bool UsersAreaActive { get; set; }
    }
}
