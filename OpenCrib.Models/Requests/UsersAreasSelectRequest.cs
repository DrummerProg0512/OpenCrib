using System;
using System.ComponentModel.DataAnnotations;

namespace OpenCrib.Models.Requests
{
    public sealed class UsersAreasSelectRequest
    {
        [Range(1, int.MaxValue, ErrorMessage = "Users Areas ID must be greater than 0.")]
        public int? UsersAreasID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Area Location ID must be greater than 0.")]
        public int? AreaLocationID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "User ID must be greater than 0.")]
        public int? UserID { get; set; }

        [Range(1, int.MaxValue, ErrorMessage = "Updated By must be greater than 0.")]
        public int? UpdatedBy { get; set; }

        public DateTime? UpdatedOnStartDate { get; set; }

        public DateTime? UpdatedOnEndDate { get; set; }

        public bool? UsersAreaActive { get; set; }
    }
}
