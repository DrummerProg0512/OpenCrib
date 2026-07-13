namespace OpenCrib.Models.Requests
{
    public sealed class StorageLocationTypeSelectRequest
    {
        public int? StorageLocationTypeID { get; set; }
        public string? StorageLocationTypeName { get; set; }
        public bool? StorageLocationTypeActive { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}