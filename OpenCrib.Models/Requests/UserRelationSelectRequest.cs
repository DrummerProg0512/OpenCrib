namespace OpenCrib.Models.Requests
{
    public sealed class UserRelationSelectRequest
    {
        public int? UserRelationID { get; set; }
        public int? UserID { get; set; }
        public int? RelatedUserID { get; set; }
        public string? RelationType { get; set; }
    }
}