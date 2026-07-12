using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class PartStorageLocationBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int StorageLocationID { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int PartID { get; set; }
        [Required]
        public decimal Qty { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}