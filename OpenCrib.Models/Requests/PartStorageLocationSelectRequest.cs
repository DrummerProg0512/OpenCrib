namespace OpenCrib.Models.Requests
{
    public sealed class PartStorageLocationSelectRequest
    {
        public int? PartStorageLocationID { get; set; }
        public int? StorageLocationID { get; set; }
        public int? PartID { get; set; }
        public decimal? QtyMin { get; set; }
        public decimal? QtyMax { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}