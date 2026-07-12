using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartItemBaseRequest
    {
        [Required]
        [StringLength(250)]
        public string PartName { get; set; } = string.Empty;
        [StringLength(2000)]
        public string? PartDescription { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int VendorID { get; set; }
        [Required]
        public decimal PartItemCost { get; set; }
        [Required]
        public decimal PartItemMin { get; set; }
        [Required]
        public decimal PartItemMax { get; set; }
        [Required]
        public int ShelfLife { get; set; }
        [Required]
        public int PartTypeCategoryID { get; set; }
        [StringLength(250)]
        public string? PartCode { get; set; }
        [Required]
        public bool PartActive { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
        [Required]
        public int UOM_ID { get; set; }
        [Required]
        public int PartUsageTypeID { get; set; }
        [Required]
        public int PartTrackingTypeID { get; set; }    }
}