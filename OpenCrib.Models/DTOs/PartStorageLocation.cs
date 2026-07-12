namespace OpenCrib.Models.DTOs
{
    public sealed class PartStorageLocation
    {
        public int PartStorageLocationID { get; set; }
        public int StorageLocationID { get; set; }
        public int PartID { get; set; }
        public decimal Qty { get; set; }
        public int UpdatedBy { get; set; }
        public string? UpdatedByUserName { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}