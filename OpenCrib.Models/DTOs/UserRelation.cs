using System;

namespace OpenCrib.Models.DTOs
{
    public class UserRelation
    {
        public int UserRelationID { get; set; }
        public int UserID { get; set; }
        public int RelatedUserID { get; set; }
        public string? RelationType { get; set; }
        public string? Notes { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}