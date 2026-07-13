using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class StorageLocationTypeUpdateRequest
    {
        [Required(ErrorMessage = "Storage location type ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Storage location type ID must be greater than 0.")]
        public int StorageLocationTypeID { get; set; }
        [StringLength(250, ErrorMessage = "Name cannot exceed 250 characters.")]
        public string? StorageLocationTypeName { get; set; }
        [StringLength(500, ErrorMessage = "Description cannot exceed 500 characters.")]
        public string? StorageLocationTypeDescription { get; set; }
        public bool? StorageLocationTypeActive { get; set; }
        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0 when provided.")]
        public int? UpdatedBy { get; set; }
    }
}