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
    public sealed class CRUD_PartAssets : ICRUD_PartAssets
    {
        private readonly IMapper _mapper;

        public CRUD_PartAssets(IMapper mapper)
        {
            _mapper = mapper;
        }

        #region Create
        public async Task<PartAssetInsertResponse> PartAssetInsert(PartAssetInsertRequest request)
        {
            var response = new PartAssetInsertResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<PartAssetInsertResponse>(request);
                    response.OriginalRequest = request;

                    var parameters = new DynamicParameters();

                    // Required numeric / identity fields
                    parameters.Add("@PartID", request.PartID, DbType.Int32);
                    parameters.Add("@AssetStatusID", request.AssetStatusID, DbType.Int32);
                    parameters.Add("@AssetCondition", request.AssetCondiftion, DbType.Int32);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32);

                    // String fields (apply max sizes consistent with stored procedure)
                    parameters.Add("@SerialNumber", request.SerialNumber ?? string.Empty, DbType.String, ParameterDirection.Input, 100);
                    parameters.Add("@AssetTag", request.AssetTag ?? string.Empty, DbType.String, ParameterDirection.Input, 1024);

                    // Date fields expected as VARCHAR(10) in stored procedure (use yyyy-MM-dd or null)
                    string? purchaseDate = request.PurchaseDate.HasValue ? request.PurchaseDate.Value.ToString("yyyy-MM-dd") : null;
                    string? warrantyExpiration = request.WarrantyExpiration.HasValue ? request.WarrantyExpiration.Value.ToString("yyyy-MM-dd") : null;
                    string? lastCalibration = request.LastCalibrationDate.HasValue ? request.LastCalibrationDate.Value.ToString("yyyy-MM-dd") : null;
                    string? nextCalibration = request.NextCalibrationDate.HasValue ? request.NextCalibrationDate.Value.ToString("yyyy-MM-dd") : null;

                    parameters.Add("@PurchaseDate", purchaseDate, DbType.String, ParameterDirection.Input, 10);
                    parameters.Add("@WarrantyExpiration", warrantyExpiration, DbType.String, ParameterDirection.Input, 10);
                    parameters.Add("@LastCalibrationDate", lastCalibration, DbType.String, ParameterDirection.Input, 10);
                    parameters.Add("@NextCalibrationDate", nextCalibration, DbType.String, ParameterDirection.Input, 10);

                    // Boolean / bit
                    parameters.Add("@IsActive", request.IsActive, DbType.Boolean);

                    // Output parameter
                    parameters.Add("@AssetID", dbType: DbType.Int64, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();
                        using (var transaction = conn.BeginTransaction())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_PartAssets_Insert]", parameters, transaction, commandType: CommandType.StoredProcedure);
                                response.NewAssetID = parameters.Get<long>("@AssetID");
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
        public async Task<PartAssetSelectResponse> PartAssetSearch(PartAssetSelectRequest request)
        {
            var response = new PartAssetSelectResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<PartAssetSelectResponse>(request);
                    
                    var parameters = new DynamicParameters();
                    parameters.Add("@AssetID", request.AssetID, DbType.Int64);
                    parameters.Add("@PartID", request.PartID, DbType.Int32);
                    parameters.Add("@SerialNumber", request.SerialNumber ?? string.Empty, DbType.String, ParameterDirection.Input, 100);
                    parameters.Add("@AssetTag", request.AssetTag ?? string.Empty, DbType.String, ParameterDirection.Input, 1024);
                    parameters.Add("@AssetStatusID", request.AssetStatusID, DbType.Int32);
                    parameters.Add("@IsActive", request.IsActive, DbType.Boolean);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32);
                    parameters.Add("@UpdatedOnStartDate", request.UpdatedOnStartDate?.ToString("yyyy-MM-dd HH:mm:ss"), DbType.String, ParameterDirection.Input, 19);
                    parameters.Add("@UpdatedOnEndDate", request.UpdatedOnEndDate?.ToString("yyyy-MM-dd HH:mm:ss"), DbType.String, ParameterDirection.Input, 19);
                    
                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();
                        var result = await conn.QueryAsync<PartAsset>("[dbo].[usp_PartAssets_Select]", parameters, commandType: CommandType.StoredProcedure);
                        response.Assets = result.AsList();
                        response.IsSuccessful = true;
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

        #region Update
        public async Task<PartAssetUpdateResponse> PartAssetUpdate(PartAssetUpdateRequest request)
        {
            var response = new PartAssetUpdateResponse();
            try
            {
                if (request != null)
                {
                    var parameters = new DynamicParameters();

                    // Map stored procedure parameters for usp_PartAssets_Update
                    parameters.Add("@AssetID", request.AssetID, DbType.Int64);
                    parameters.Add("@PartID", request.PartID, DbType.Int32);
                    // For update, pass null when not provided so the proc leaves the column unchanged
                    parameters.Add("@SerialNumber", request.SerialNumber, DbType.String, ParameterDirection.Input, 100);
                    parameters.Add("@AssetTag", request.AssetTag, DbType.String, ParameterDirection.Input, 1024);
                    parameters.Add("@AssetStatusID", request.AssetStatusID, DbType.Int32);

                    string? purchaseDate = request.PurchaseDate.HasValue ? request.PurchaseDate.Value.ToString("yyyy-MM-dd") : null;
                    string? warrantyExpiration = request.WarrantyExpiration.HasValue ? request.WarrantyExpiration.Value.ToString("yyyy-MM-dd") : null;
                    string? lastCalibration = request.LastCalibrationDate.HasValue ? request.LastCalibrationDate.Value.ToString("yyyy-MM-dd") : null;
                    string? nextCalibration = request.NextCalibrationDate.HasValue ? request.NextCalibrationDate.Value.ToString("yyyy-MM-dd") : null;

                    parameters.Add("@PurchaseDate", purchaseDate, DbType.String, ParameterDirection.Input, 10);
                    parameters.Add("@WarrantyExpiration", warrantyExpiration, DbType.String, ParameterDirection.Input, 10);
                    parameters.Add("@LastCalibrationDate", lastCalibration, DbType.String, ParameterDirection.Input, 10);
                    parameters.Add("@NextCalibrationDate", nextCalibration, DbType.String, ParameterDirection.Input, 10);

                    parameters.Add("@AssetCondiftion", request.AssetCondiftion, DbType.Int32);
                    parameters.Add("@IsActive", request.IsActive, DbType.Boolean);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32);

                    // Output parameter for rows affected
                    parameters.Add("@RowsAffected", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();
                        using (var transaction = conn.BeginTransaction())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_PartAssets_Update]", parameters, transaction, commandType: CommandType.StoredProcedure);
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
