namespace OpenCrib.Models.Requests
{
    public sealed class UOMSelectRequest
    {
        public int? UOMID { get; set; }
        public string? Name { get; set; }
        public string? Abbreviation { get; set; }
    }
}