using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;

namespace OpenCrib.Services.ICRUD
{
    public interface ICRUD_AreaLocationsRelation
    {
        Task<AreaLocationRelationSelectResponse> AreaLocationsRelationSearch(AreaLocationRelationSelectRequest request);
        Task<AreaLocationRelationInsertResponse> AreaLocationsRelationsInsert(AreaLocationRelationInsertRequest request);
        Task<AreaLocationRelationUpdateResponse> AreaLocationsRelationsUpdate(AreaLocationRelationUpdateRequest request);
    }
}
