namespace OpenCrib.Models.Requests
{
    public sealed class TransactionAssetSelectRequest
    {
        public long? TransactionAssetID { get; set; }
        public long? AssetID { get; set; }
        public int? TransactionID { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOnStart { get; set; }
        public DateTime? UpdatedOnEnd { get; set; }
    }
}