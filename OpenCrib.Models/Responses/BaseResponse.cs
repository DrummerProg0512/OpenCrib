namespace OpenCrib.Models.Responses
{
    public abstract class BaseResponse
    {
        public bool IsSuccessful { get; set; }
        public string? exMessage { get; set; }
    }
}
