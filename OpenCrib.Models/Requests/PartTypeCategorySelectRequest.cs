namespace OpenCrib.Models.Requests
{
    public sealed class PartTypeCategorySelectRequest
    {
        public int? PartTypeCategoryID { get; set; }
        public string? CategoryName { get; set; }
        public bool? CategoryActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}