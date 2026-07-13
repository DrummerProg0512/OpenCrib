namespace OpenCrib.Models.DTOs
{
    public sealed class TransactionAsset
    {
        public long TransactionAssetID { get; set; }
        public long AssetID { get; set; }
        public int TransactionID { get; set; }
        public int Quantity { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}