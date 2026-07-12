using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class StorageLocationUpdateRequest
    {
        [Required]
        [Range(1, int.MaxValue)]
        public int StorageLocationID { get; set; }
        [Range(1, int.MaxValue)]
        public int? AreaLocationID { get; set; }
        [StringLength(250)]
        public string? StorageLocationName { get; set; }
        [StringLength(150)]
        public string? StorageLocationCode { get; set; }
        [StringLength(500)]
        public string? StorageLocationDescription { get; set; }
        public bool? StorageLocationActive { get; set; }
        [Range(1, int.MaxValue)]
        public int? UpdatedBy { get; set; }
    }
}