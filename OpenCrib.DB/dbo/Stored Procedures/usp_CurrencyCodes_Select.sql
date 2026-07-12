CREATE PROCEDURE [dbo].[usp_CurrencyCodes_Select]
    @CurrencyCodeID INT = NULL,
    @CountryName NVARCHAR(250) = NULL,
    @CurrencyName NVARCHAR(150) = NULL,
    @CurrencyCode NVARCHAR(20) = NULL,
    @IsDefaultCurrency BIT = NULL,
    @UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @CountryName = NULLIF(@CountryName, '');
        SET @CurrencyName = NULLIF(@CurrencyName, '');
        SET @CurrencyCode = NULLIF(@CurrencyCode, '');
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            cc.[CurrencyCodeID],
            cc.[CountryName],
            cc.[CurrencyName],
            cc.[CurrencyCode],
            cc.[IsDefaultCurrency],
            cc.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            cc.[UpdatedOn]
        FROM
            [dbo].[CurrencyCodes] cc
            INNER JOIN [dbo].[Users] u ON cc.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@CurrencyCodeID, 0) > 0 AND cc.[CurrencyCodeID] = @CurrencyCodeID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@CurrencyCodeID, 0) = 0
                    AND (@CountryName IS NULL OR cc.[CountryName] LIKE '%' + @CountryName + '%')
                    AND (@CurrencyName IS NULL OR cc.[CurrencyName] LIKE '%' + @CurrencyName + '%')
                    AND (@CurrencyCode IS NULL OR cc.[CurrencyCode] LIKE '%' + @CurrencyCode + '%')
                    AND (@IsDefaultCurrency IS NULL OR cc.[IsDefaultCurrency] = @IsDefaultCurrency)
                    AND (@UpdatedOnStartDate IS NULL OR cc.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR cc.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            cc.[CurrencyCodeID];
        
        RETURN 0;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN @ErrorNumber;
    END CATCH
END;