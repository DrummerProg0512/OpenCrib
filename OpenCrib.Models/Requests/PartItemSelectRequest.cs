namespace OpenCrib.Models.Requests
{
    public sealed class PartItemSelectRequest
    {
        public int? PartID { get; set; }
        public string? PartName { get; set; }
        public int? VendorID { get; set; }
        public decimal? PartItemCostMin { get; set; }
        public decimal? PartItemCostMax { get; set; }
        public bool? PartActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}