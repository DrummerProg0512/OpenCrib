namespace OpenCrib.Models.DTOs
{
    public sealed class AreaLocationRelation
    {
        public int AreaLocationRelationID { get; set; }
        public int AreaLocationParentID { get; set; }
        public int ParentAreaLocationID { get; set; }
        public string? ParentLocationName { get; set; }
        public int AreaLocationChildID { get; set; }
        public int ChildAreaLocationID { get; set; }
        public string? ChildLocationName { get; set; }
        public int UpdatedBy { get; set; }
        public int UserID { get; set; }
        public string? UserName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}
