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
    public sealed class CRUD_AreaLocationTypes : ICRUD_AreaLocationTypes
    {
        private readonly IMapper _mapper;

        public CRUD_AreaLocationTypes(IMapper mapper)
        {
            _mapper = mapper;
        }

        #region Create
        public async Task<AreaLocationTypeInsertResponse> AreaLocationTypeInsert(AreaLocationTypeInsertRequest request)
        {
            var response = new AreaLocationTypeInsertResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<AreaLocationTypeInsertResponse>(request);

                    var parameters = new DynamicParameters();
                    parameters.Add("@AreaLocationTypeName", request.AreaLocationTypeName, DbType.String);
                    parameters.Add("@AreaLocationTypeActive", request.AreaLocationTypeActive, DbType.Boolean);
                    parameters.Add("@AreaLocationTypeID", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    using (var connection = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await connection.OpenAsync();
                        
                        using (var transaction = connection.BeginTransaction())
                        {
                            try
                            {
                                var result = await connection.ExecuteAsync("[dbo].[usp_AreaLocationTypes_Insert]", parameters, commandType: CommandType.StoredProcedure);
                                response.NewAreaLocationTypeID = parameters.Get<int>("@AreaLocationTypeID");
                                response.IsSuccessful = true;
                                await transaction.CommitAsync();
                            }
                            catch (Exception ex)
                            {
                                response.IsSuccessful = false;
                                response.exMessage = $"Transaction Error: {ex.Message}";
                                await transaction.RollbackAsync();
                                throw;
                            }
                        }
                    }
                }
                else
                { 
                    response.IsSuccessful = false;
                    response.exMessage = "Request is null.";
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
        public async Task<AreaLocationTypeSelectResponse> AreaLocationTypeSearch(AreaLocationTypeSelectRequest request)
        {
            var response = new AreaLocationTypeSelectResponse();
            try
            {
                if (request != null)
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@AreaLocationTypeID", request.AreaLocationTypeID, DbType.Int32);
                    parameters.Add("@AreaLocationTypeName", request.AreaLocationTypeName, DbType.String);
                    parameters.Add("@AreaLocationTypeActive", request.AreaLocationTypeActive, DbType.Boolean);
                    
                    using (var connection = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await connection.OpenAsync();
                        var result = await connection.QueryAsync<AreaLocationType>("[dbo].[usp_AreaLocationTypes_Select]", parameters, commandType: CommandType.StoredProcedure);
                        response.Types = result.ToList();
                        response.IsSuccessful = true;
                    }
                }
                else
                {
                    response.IsSuccessful = false;
                    response.exMessage = "Request is null.";
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
        public async Task<AreaLocationTypeUpdateResponse> AreaLocationTypeUpdate(AreaLocationTypeUpdateRequest request)
        {
            var response = new AreaLocationTypeUpdateResponse();
            try
            {
                if (request != null)
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@AreaLocationTypeID", request.AreaLocationTypeID, DbType.Int32);
                    parameters.Add("@AreaLocationTypeName", request.AreaLocationTypeName, DbType.String);
                    parameters.Add("@AreaLocationTypeActive", request.AreaLocationTypeActive, DbType.Boolean);
                    parameters.Add("@RowsAffected", dbType: DbType.Int32, direction: ParameterDirection.Output);
                    using (var connection = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await connection.OpenAsync();
                        var result = await connection.ExecuteAsync("[dbo].[usp_AreaLocationTypes_Update]", parameters, commandType: CommandType.StoredProcedure);
                        response.RowsAffected = parameters.Get<int>("@RowsAffected");
                        response.IsSuccessful = true;
                    }
                }
                else
                {
                    response.IsSuccessful = false;
                    response.exMessage = "Request is null.";
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
