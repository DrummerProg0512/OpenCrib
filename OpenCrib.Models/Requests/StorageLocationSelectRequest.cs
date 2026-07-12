namespace OpenCrib.Models.Requests
{
    public sealed class StorageLocationSelectRequest
    {
        public int? StorageLocationID { get; set; }
        public int? AreaLocationID { get; set; }
        public string? StorageLocationName { get; set; }
        public string? StorageLocationCode { get; set; }
        public string? StorageLocationDescription { get; set; }
        public bool? StorageLocationActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}