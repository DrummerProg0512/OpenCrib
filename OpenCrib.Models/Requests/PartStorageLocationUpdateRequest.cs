using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class PartStorageLocationUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int PartStorageLocationID { get; set; }
        [Range(1, int.MaxValue)]
        public int? StorageLocationID { get; set; }
        [Range(1, int.MaxValue)]
        public int? PartID { get; set; }
        public decimal? Qty { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}