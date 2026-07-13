namespace OpenCrib.Models.DTOs
{
    public sealed class StorageLocationType
    {
        public int StorageLocationTypeID { get; set; }
        public string StorageLocationTypeName { get; set; } = string.Empty;
        public string? StorageLocationTypeDescription { get; set; }
        public bool StorageLocationTypeActive { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}