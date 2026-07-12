namespace OpenCrib.Models.DTOs
{
    public sealed class PartItem
    {
        public int PartID { get; set; }
        public string PartName { get; set; } = string.Empty;
        public string PartDescription { get; set; } = string.Empty;
        public int VendorID { get; set; }
        public decimal PartItemCost { get; set; }
        public decimal PartItemMin { get; set; }
        public decimal PartItemMax { get; set; }
        public int ShelfLife { get; set; }
        public int PartTypeCategoryID { get; set; }
        public string PartCode { get; set; } = string.Empty;
        public bool PartActive { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
        public int UOM_ID { get; set; }
        public int PartUsageTypeID { get; set; }
        public int PartTrackingTypeID { get; set; }
    }
}