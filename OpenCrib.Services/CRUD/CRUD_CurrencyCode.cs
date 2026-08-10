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
            var response = new CurrencyCodeInsertResponse
            try
            {
                if (request != null)
                {
                    response = _mapper.Map<CurrencyCodeInsertResponse>(request);

                    var parameters = new DynamicParameters();
                    parameters.Add("@CountryName", request.CurrencyName, DbType.String, ParameterDirection.Input);
                    //Check DTOs, Request and Response Models for stored procedures for Currency Code (Fields do not match)
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
