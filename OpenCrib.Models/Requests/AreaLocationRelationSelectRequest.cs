namespace OpenCrib.Models.Requests
{
    public sealed class AreaLocationRelationSelectRequest
    {
        public int? AreaLocationRelationID { get; set; }
        public int? AreaLocationParentID { get; set; }
        public int? AreaLocationChildID { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStartDate { get; set; }
        public DateTime? UpdatedOnEndDate { get; set; }
    }
}
