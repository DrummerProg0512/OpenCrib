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
    public sealed class CRUD_CurrencyCode
    {
        private readonly IMapper _mapper;

        public CRUD_CurrencyCode(IMapper mapper)
        {
            _mapper = mapper;
        }

        #region Create
        public async Task<CurrencyCodeInsertResponse> CurrencyCodeInsert(CurrencyCodeInsertRequest request)
        {
            var response = new CurrencyCodeInsertResponse();
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<CurrencyCodeInsertResponse>(request);

                    var parameters = new DynamicParameters();
                    parameters.Add("@CountryName", request.CountryName, DbType.String, ParameterDirection.Input);
                    parameters.Add("@CurrencyName", request.CurrencyName, DbType.String, ParameterDirection.Input);
                    parameters.Add("@CurrencyCode", request.CurrencyCode, DbType.String, ParameterDirection.Input);
                    parameters.Add("@IsDefaultCurrency", request.IsDefaultCurrency, DbType.Boolean, ParameterDirection.Input);
                    parameters.Add("@UpdatedBy", request.UpdatedBy, DbType.Int32, ParameterDirection.Input);
                    parameters.Add("@CurrencyCodeID", dbType: DbType.Int32, direction: ParameterDirection.Output);

                    using (var conn = new SqlConnection(Connections.Conn.OpenCribDB))
                    {
                        await conn.OpenAsync();

                        using (var transaction = await conn.BeginTransactionAsync())
                        {
                            try
                            {
                                var result = await conn.ExecuteAsync("[dbo].[usp_CurrencyCodes_Insert]", parameters, transaction, commandType: CommandType.StoredProcedure);
                                response.NewCurrencyCodeID = parameters.Get<int>("@CurrencyCodeID");
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
