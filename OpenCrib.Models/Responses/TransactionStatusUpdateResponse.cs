namespace OpenCrib.Models.Responses
{
    public sealed class TransactionStatusUpdateResponse : BaseResponse
    {
        public int RowsAffected { get; set; }
    }
}