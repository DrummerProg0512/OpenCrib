namespace OpenCrib.Models.Requests
{
    public sealed class UserSelectRequest
    {
        public int? UserID { get; set; }
        public string? Username { get; set; }
        public string? Email { get; set; }
        public bool? IsActive { get; set; }
    }
}