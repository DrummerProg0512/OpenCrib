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
    public sealed class CRUD_PartAssetAttachment : ICRUD_PartAssetAttachment
    {
        private readonly IMapper _mapper;

        public CRUD_PartAssetAttachment(IMapper mapper)
        {
            _mapper = mapper;
        }

        #region Create
        public async Task<PartAssetsAttachmentInsertResponse> PartAssetsAttachmentInsert(PartAssetsAttachmentInsertRequest request)
        {
            var response = new PartAssetsAttachmentInsertResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<PartAssetsAttachmentInsertResponse>(request);

                    var parameters = new DynamicParameters();

                    parameters.Add("@AssetID", request.AssetID, DbType.Int64);
                    parameters.Add("@ImageData", request.ImageData, DbType.Binary);
                    parameters.Add("@FileName", request.FileName, DbType.String);
                    parameters.Add("@FileDescription", request.FileDescription, DbType.String);
                    parameters.Add("@FileType", request.FileType, DbType.String);
                    parameters.Add("@MimeType", request.MimeType, DbType.String);
                    parameters.Add("@FileSize", request.FileSize, DbType.Int32);
                    parameters.Add("@ImageActive", request.ImageActive, DbType.Boolean);
                    parameters.Add("@UploadedBy", request.UploadedBy, DbType.Int32);
                    parameters.Add("@PartAssetsAttachmentID", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();

                        using (var transaction = conn.BeginTransaction())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_PartAssetsAttachments_Insert]", parameters, transaction, commandType: CommandType.StoredProcedure);
                                response.IsSuccessful = true;
                                response.NewPartAssetsAttachmentID = parameters.Get<int>("@PartAssetsAttachmentID");
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
        public async Task<PartAssetsAttachmentSelectResponse> PartAssetsAttachmentSearch(PartAssetsAttachmentSelectRequest request)
        {
            var response = new PartAssetsAttachmentSelectResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<PartAssetsAttachmentSelectResponse>(request);
                    var parameters = new DynamicParameters();

                    parameters.Add("@PartAssetsAttachmentID", request.PartAssetsAttachmentID, DbType.Int32);
                    parameters.Add("@AssetID", request.AssetID, DbType.Int64);
                    parameters.Add("@FileName", string.IsNullOrWhiteSpace(request.FileName) ? null : request.FileName, DbType.String);
                    parameters.Add("@ImageActive", request.ImageActive, DbType.Boolean);
                    parameters.Add("@UploadedBy", request.UploadedBy, DbType.Int32);

                    // Stored proc expects varchar(19) with format 'YYYY-MM-DD HH:mm:ss'
                    parameters.Add("@UploadedOnStartDate", request.UploadedOnStart.HasValue ? request.UploadedOnStart.Value.ToString("yyyy-MM-dd HH:mm:ss") : null, DbType.String);
                    parameters.Add("@UploadedOnEndDate", request.UploadedOnEnd.HasValue ? request.UploadedOnEnd.Value.ToString("yyyy-MM-dd HH:mm:ss") : null, DbType.String);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();
                        var result = await conn.QueryAsync<PartAssetsAttachment>("[dbo].[usp_PartAssetsAttachments_Select]", parameters, commandType: CommandType.StoredProcedure);
                        response.Attachments = result.ToList();
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
        public async Task<PartAssetsAttachmentUpdateResponse> PartAssetsAttachmentUpdate(PartAssetsAttachmentUpdateRequest request)
        {
            var response = new PartAssetsAttachmentUpdateResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<PartAssetsAttachmentUpdateResponse>(request);
                    var parameters = new DynamicParameters();

                    parameters.Add("@PartAssetsAttachmentID", request.PartAssetsAttachmentID, DbType.Int32);
                    parameters.Add("@AssetID", request.AssetID, DbType.Int64);
                    parameters.Add("@FileName", string.IsNullOrWhiteSpace(request.FileName) ? null : request.FileName, DbType.String);
                    parameters.Add("@FileType", string.IsNullOrWhiteSpace(request.FileType) ? null : request.FileType, DbType.String);
                    parameters.Add("@ImageActive", request.ImageActive, DbType.Boolean);
                    parameters.Add("@UploadedBy", request.UploadedBy, DbType.Int32);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();
                        using (var transaction = conn.BeginTransaction())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_PartAssetsAttachments_Update]", parameters, transaction, commandType: CommandType.StoredProcedure);
                                response.IsSuccessful = true;
                                response.RowsAffected = result;
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
