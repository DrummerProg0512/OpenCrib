
CREATE PROCEDURE [dbo].[usp_PartCostHistory_Select]
    @PartCostHistoryID INT = NULL,
    @PartID INT = NULL,
    @CurrencyCodeID INT = NULL,
    @UpdatedBy INT = NULL,
    @ExchangeRateDateStartDate VARCHAR(10) = NULL,  -- Format: 'YYYY-MM-DD'
    @ExchangeRateDateEndDate VARCHAR(10) = NULL,    -- Format: 'YYYY-MM-DD'
    @UpdatedOnStartDate VARCHAR(19) = NULL,         -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL            -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @ExchangeRateDateStartDate = NULLIF(@ExchangeRateDateStartDate, '');
        SET @ExchangeRateDateEndDate = NULLIF(@ExchangeRateDateEndDate, '');
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            pch.[PartCostHistoryID],
            pch.[PartID],
            pi.[PartID] AS [PartIDRef],
            pi.[PartCode],
            pi.[PartName],
            pch.[CostAmount],
            pch.[CurrencyCodeID],
            cc.[CurrencyCodeID] AS [CurrencyCodeIDRef],
            cc.[CurrencyCode],
            cc.[CurrencyName],
            pch.[ExchangeRate],
            pch.[ExchangeRateDate],
            pch.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            pch.[UpdatedOn]
        FROM
            [dbo].[PartCostHistory] pch
            INNER JOIN [dbo].[PartsItems] pi ON pch.[PartID] = pi.[PartID]
            INNER JOIN [dbo].[CurrencyCodes] cc ON pch.[CurrencyCodeID] = cc.[CurrencyCodeID]
            INNER JOIN [dbo].[Users] u ON pch.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartCostHistoryID, 0) > 0 AND pch.[PartCostHistoryID] = @PartCostHistoryID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartCostHistoryID, 0) = 0
                    AND (ISNULL(@PartID, 0) = 0 OR pch.[PartID] = @PartID)
                    AND (ISNULL(@CurrencyCodeID, 0) = 0 OR pch.[CurrencyCodeID] = @CurrencyCodeID)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR pch.[UpdatedBy] = @UpdatedBy)
                    AND (@ExchangeRateDateStartDate IS NULL OR pch.[ExchangeRateDate] >= CONVERT(DATE, @ExchangeRateDateStartDate))
                    AND (@ExchangeRateDateEndDate IS NULL OR pch.[ExchangeRateDate] <= CONVERT(DATE, @ExchangeRateDateEndDate))
                    AND (@UpdatedOnStartDate IS NULL OR pch.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR pch.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            pch.[PartCostHistoryID] DESC;
        
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