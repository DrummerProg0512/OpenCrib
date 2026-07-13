using System;

namespace OpenCrib.Models.DTOs
{
    public class UOM
    {
        public int UOMID { get; set; }
        public string? Name { get; set; }
        public string? Abbreviation { get; set; }
        public string? Description { get; set; }
        public int UpdatedBy { get; set; }
        public DateTime UpdatedOn { get; set; }
    }
}