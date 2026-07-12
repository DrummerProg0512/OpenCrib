using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartItemUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartID { get; set; }
        [StringLength(250)]
        public string? PartName { get; set; }
        [StringLength(2000)]
        public string? PartDescription { get; set; }
        [Range(1, int.MaxValue)]
        public int? VendorID { get; set; }
        public decimal? PartItemCost { get; set; }
        public decimal? PartItemMin { get; set; }
        public decimal? PartItemMax { get; set; }
        public int? ShelfLife { get; set; }
        public int? PartTypeCategoryID { get; set; }
        [StringLength(250)]
        public string? PartCode { get; set; }
        public bool? PartActive { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
        public int? UOM_ID { get; set; }
        public int? PartUsageTypeID { get; set; }
        public int? PartTrackingTypeID { get; set; }    }
}