using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public abstract class AreaLocationRelationBaseRequest
    {
        [Required(ErrorMessage = "Area location parent ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area location parent ID must be greater than 0.")]
        public int AreaLocationParentID { get; set; }

        [Required(ErrorMessage = "Area location child ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Area location child ID must be greater than 0.")]
        public int AreaLocationChildID { get; set; }

        [Required(ErrorMessage = "Updated by user ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Updated by user ID must be greater than 0.")]
        public int UpdatedBy { get; set; }
    }
}
