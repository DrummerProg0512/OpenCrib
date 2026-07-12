using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class StorageLocationBaseRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int AreaLocationID { get; set; }
        [Required]
        [StringLength(250)]
        public string StorageLocationName { get; set; } = string.Empty;
        [StringLength(150)]
        public string? StorageLocationCode { get; set; }
        [StringLength(500)]
        public string? StorageLocationDescription { get; set; }
        [Required]
        public bool StorageLocationActive { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}