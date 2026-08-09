using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;
using System;
using System.Collections.Generic;
using System.Text;

namespace OpenCrib.Services.ICRUD
{
    public interface ICRUD_AreaLocations
    {
        Task<AreaLocationInsertResponse> AreaLocationInsert(AreaLocationInsertRequest request);
        Task<AreaLocationSelectResponse> AreaLocationSearch(AreaLocationSelectRequest request);
        Task<AreaLocationUpdateResponse> AreaLocationUpdate(AreaLocationUpdateRequest request);
    }
}
