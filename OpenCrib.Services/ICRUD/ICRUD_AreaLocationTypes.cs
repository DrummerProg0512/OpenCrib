using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Services.ICRUD
{
    public interface ICRUD_AreaLocationTypes
    {
        Task<AreaLocationTypeInsertResponse> AreaLocationTypeInsert(AreaLocationTypeInsertRequest request);
        Task<AreaLocationTypeSelectResponse> AreaLocationTypeSearch(AreaLocationTypeSelectRequest request);
        Task<AreaLocationTypeUpdateResponse> AreaLocationTypeUpdate(AreaLocationTypeUpdateRequest request);
    }
}
