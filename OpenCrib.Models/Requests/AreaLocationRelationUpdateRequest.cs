using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class AreaLocationRelationUpdateRequest
    {
        [Required(ErrorMessage = "Area location relation ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area location relation ID must be greater than 0.")]
        public int AreaLocationRelationID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Area location parent ID must be greater than 0 when provided.")]
        public int? AreaLocationParentID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Area location child ID must be greater than 0 when provided.")]
        public int? AreaLocationChildID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0 when provided.")]
        public int? UpdatedBy { get; set; }
    }
}
