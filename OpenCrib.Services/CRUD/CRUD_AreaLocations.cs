using AutoMapper;
using Dapper;
using Microsoft.Data.SqlClient;
using OpenCrib.Models.DTOs;
using OpenCrib.Models.Requests;
using OpenCrib.Models.Responses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Text;


namespace OpenCrib.Services.CRUD
{
    public sealed class CRUD_AreaLocations
    {
        private readonly IMapper _mapper;

        public CRUD_AreaLocations(IMapper mapper)
        {
            _mapper = mapper;
        }

        #region Create
        public async Task<AreaLocationInsertResponse> AreaLocationInsert(AreaLocationInsertRequest request)
        {
            var response = new AreaLocationInsertResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<AreaLocationInsertResponse>(request);
                    var parameters = new DynamicParameters();
                    parameters.Add("@AreaLocationTypeID", request.AreaLocationTypeID, DbType.Int32);
                    parameters.Add("@AreaLocationName", request.AreaLocationName, DbType.String);
                    parameters.Add("@AreaLocationCode", request.AreaLocationCode, DbType.String);
                    parameters.Add("@AreaLocationDescription", request.AreaLocationDescription, DbType.String);
                    parameters.Add("@AreaLocationActive", request.AreaLocationActive, DbType.Boolean);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.String);
                    parameters.Add("@AreaLocationID", DbType.Int32, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();

                        using (var transaction = await conn.BeginTransactionAsync())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_AreaLocations_Insert]", parameters, transaction: transaction, commandType: CommandType.StoredProcedure);
                                response.IsSuccessful = true;
                                response.NewAreaLocationID = parameters.Get<int>("@AreaLocationID");
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
        public async Task<AreaLocationSelectResponse> AreaLocationSearch(AreaLocationSelectRequest request)
        {
            var response = new AreaLocationSelectResponse();
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@AreaLocationID", request.AreaLocationID, DbType.Int32);
                parameters.Add("@AreaLocationTypeID", request.AreaLocationTypeID, DbType.Int32);
                parameters.Add("@AreaLocationName", request.AreaLocationName, DbType.String);
                parameters.Add("@AreaLocationCode", request.AreaLocationCode, DbType.String);
                parameters.Add("@AreaLocationActive", request.AreaLocationActive, DbType.Boolean);
                parameters.Add("@UpdatedBy", request.UserID, DbType.Int32);
                parameters.Add("@UpdatedOnStartDate", request.UpdatedOnStart?.ToString("yyyy-MM-dd HH:mm:ss"), DbType.String);
                parameters.Add("@UpdatedOnEndDate", request.UpdatedOnEnd?.ToString("yyyy-MM-dd HH:mm:ss"), DbType.String);
                using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                {
                    await conn.OpenAsync();
                    var result = await conn.QueryAsync<AreaLocation>("[dbo].[usp_AreaLocations_Select]", parameters, commandType: CommandType.StoredProcedure);
                    response.Locations = result.AsList();
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

        #endregion

    }
}
