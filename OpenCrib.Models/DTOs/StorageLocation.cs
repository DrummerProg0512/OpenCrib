namespace OpenCrib.Models.DTOs
{
    public sealed class StorageLocation
    {
        public int StorageLocationID { get; set; }
        public int AreaLocationID { get; set; }
        public string StorageLocationName { get; set; } = string.Empty;
        public string? StorageLocationCode { get; set; }
        public string? StorageLocationDescription { get; set; }
        public bool StorageLocationActive { get; set; }
        public int UpdatedBy { get; set; }
        public string? UpdatedByUserName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}