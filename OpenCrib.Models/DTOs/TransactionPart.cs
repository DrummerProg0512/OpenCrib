namespace OpenCrib.Models.DTOs
{
    public sealed class TransactionPart
    {
        public int TransactionPartID { get; set; }
        public int TransactionID { get; set; }
        public int PartID { get; set; }
        public decimal Quantity { get; set; }
        public decimal UnitCost { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}