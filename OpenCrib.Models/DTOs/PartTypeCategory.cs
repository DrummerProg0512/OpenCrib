namespace OpenCrib.Models.DTOs
{
    public sealed class PartTypeCategory
    {
        public int PartTypeCategoryID { get; set; }
        public string CategoryName { get; set; } = string.Empty;
        public string? CategoryDescription { get; set; }
        public bool CategoryActive { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}