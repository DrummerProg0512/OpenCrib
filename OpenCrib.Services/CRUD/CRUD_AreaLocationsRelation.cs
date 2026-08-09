using AutoMapper;
using Dapper;
using Microsoft.Data.SqlClient;
using OpenCrib.Models.DTOs;
using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;
using OpenCrib.Services.ICRUD;
using System.Data;
using System.Data.Common;

namespace OpenCrib.Services.CRUD
{
    public sealed class CRUD_AreaLocationsRelation : ICRUD_AreaLocationsRelation
    {
        private readonly IMapper _mapper;

        public CRUD_AreaLocationsRelation(IMapper mapper)
        {
            _mapper = mapper;
        }

        #region Create
        public async Task<AreaLocationRelationInsertResponse> AreaLocationsRelationsInsert(AreaLocationRelationInsertRequest request)
        {
            var response = new AreaLocationRelationInsertResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<AreaLocationRelationInsertResponse>(request);

                    var parameters = new DynamicParameters();
                    parameters.Add("@AreaLocationParentID", request.AreaLocationParentID, DbType.Int32);
                    parameters.Add("@AreaLocationChildID", request.AreaLocationChildID, DbType.Int32);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32);
                    parameters.Add("@AreaLocationRelationID", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();

                        using (var transaction = conn.BeginTransaction())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_AreaLocationRelations_Insert]", parameters, transaction, commandType: CommandType.StoredProcedure);
                                response.NewAreaLocationRelationID = parameters.Get<int>("@AreaLocationRelationID");
                                response.IsSuccessful = true;
                                await transaction.CommitAsync();
                            }
                            catch (Exception ex)
                            {
                                await transaction.RollbackAsync();
                                response.IsSuccessful = false;
                                response.exMessage = ex.Message;
                            }
                        }
                    } 
                }
                else
                {
                    response.IsSuccessful = false;
                    response.exMessage = "Request object is null.";
                }
            }
            catch (SqlException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"SQL Error: {ex.Message}";
            }
            catch (TimeoutException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Timeout Error: {ex.Message}";
            }
            catch (InvalidOperationException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Invalid Operation: {ex.Message}";
            }
            catch (DbException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Database Error: {ex.Message}";
            }
            catch (Exception ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"General Error: {ex.Message}";
            }
            return response;
        }
        #endregion

        #region Retrieve
        public async Task<AreaLocationRelationSelectResponse> AreaLocationsRelationSearch(AreaLocationRelationSelectRequest request)
        {
            var response = new AreaLocationRelationSelectResponse();
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@AreaLocationRelationID", request.AreaLocationRelationID, DbType.Int32);
                parameters.Add("@AreaLocationParentID", request.AreaLocationParentID, DbType.Int32);
                parameters.Add("@AreaLocationChildID", request.AreaLocationChildID, DbType.Int32);
                parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32);
                parameters.Add("@UpdatedOnStartDate", request.UpdatedOnStartDate?.ToString("yyyy-MM-dd HH:mm:ss"), DbType.String);
                parameters.Add("@UpdatedOnEndDate", request.UpdatedOnEndDate?.ToString("yyyy-MM-dd HH:mm:ss"), DbType.String);

                using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                {
                    await conn.OpenAsync();
                    var result = await conn.QueryAsync<AreaLocationRelation>("[dbo].[usp_AreaLocationRelations_Select]", parameters, commandType: CommandType.StoredProcedure);
                    response.Relations = result.ToList();
                    response.IsSuccessful = true;
                }
            }
            catch (SqlException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"SQL Error: {ex.Message}";
            }
            catch (TimeoutException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Timeout Error: {ex.Message}";
            }
            catch (InvalidOperationException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Invalid Operation: {ex.Message}";
            }
            catch (DbException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Database Error: {ex.Message}";
            }
            catch (Exception ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"General Error: {ex.Message}";
            }
            return response;
        }
        #endregion

        #region Update
        public async Task<AreaLocationRelationUpdateResponse> AreaLocationsRelationsUpdate(AreaLocationRelationUpdateRequest request)
        {
            var response = new AreaLocationRelationUpdateResponse();
            try
            {
                if (request != null)
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@AreaLocationRelationID", request.AreaLocationRelationID, DbType.Int32);
                    parameters.Add("@AreaLocationParentID", request.AreaLocationParentID, DbType.Int32);
                    parameters.Add("@AreaLocationChildID", request.AreaLocationChildID, DbType.Int32);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32);
                    parameters.Add("@RowsAffected", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();
                        using (var transaction = conn.BeginTransaction())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_AreaLocationRelations_Update]", parameters, transaction, commandType: CommandType.StoredProcedure);
                                response.RowsAffected = parameters.Get<int>("@RowsAffected");
                                response.IsSuccessful = true;
                                await transaction.CommitAsync();
                            }
                            catch (Exception ex)
                            {
                                await transaction.RollbackAsync();
                                response.IsSuccessful = false;
                                response.exMessage = ex.Message;
                            }
                        }
                    }
                }
                else
                {
                    response.IsSuccessful = false;
                    response.exMessage = "Request object is null.";
                }
            }
            catch (SqlException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"SQL Error: {ex.Message}";
            }
            catch (TimeoutException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Timeout Error: {ex.Message}";
            }
            catch (InvalidOperationException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Invalid Operation: {ex.Message}";
            }
            catch (DbException ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"Database Error: {ex.Message}";
            }
            catch (Exception ex)
            {
                response.IsSuccessful = false;
                response.exMessage = $"General Error: {ex.Message}";
            }
            return response;
        }
        #endregion
    }
}
