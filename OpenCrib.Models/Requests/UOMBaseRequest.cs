using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class UOMBaseRequest
    {
        [Required]
        [StringLength(200)]
        public string? Name { get; set; }
        [StringLength(50)]
        public string? Abbreviation { get; set; }
        [StringLength(2000)]
        public string? Description { get; set; }
        [Required]
        [Range(1, int.MaxValue)]
        public int UpdatedBy { get; set; }
    }
}