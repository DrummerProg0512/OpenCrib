namespace OpenCrib.Models.Requests
{
    public sealed class UserSelectRequest
    {
        public int? UserID { get; set; }
        public string? UserName { get; set; }
        public string? UserLastName { get; set; }
        public string? UserCode { get; set; }
        public string? UserEmail { get; set; }
        public int? UserRoleID { get; set; }
        public int? UserTypeID { get; set; }
        public bool? UserActive { get; set; }
    }
}