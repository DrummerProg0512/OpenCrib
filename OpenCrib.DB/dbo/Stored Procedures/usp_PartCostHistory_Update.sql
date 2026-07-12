
create PROCEDURE [dbo].[usp_PartCostHistory_Update]
    @PartCostHistoryID INT,
    @PartID INT = NULL,
    @CostAmount DECIMAL(12, 2) = NULL,
    @CurrencyCodeID INT = NULL,
    @ExchangeRate DECIMAL(12, 2) = NULL,
    @ExchangeRateDate VARCHAR(10) = NULL,  -- Format: 'YYYY-MM-DD'
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartCostHistoryID IS NULL OR @PartCostHistoryID = 0
        BEGIN
            RAISERROR('PartCostHistoryID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartCostHistory] WHERE [PartCostHistoryID] = @PartCostHistoryID)
        BEGIN
            RAISERROR('PartCostHistoryID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF ISNULL(@PartID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
            BEGIN
                RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@CurrencyCodeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[CurrencyCodes] WHERE [CurrencyCodeID] = @CurrencyCodeID)
            BEGIN
                RAISERROR('CurrencyCodeID does not exist in CurrencyCodes table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UpdatedBy, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
            BEGIN
                RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Normalize empty strings to NULL for date parameter
        SET @ExchangeRateDate = NULLIF(@ExchangeRateDate, '');
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[PartCostHistory]
        SET
            [PartID] = ISNULL(@PartID, [PartID]),
            [CostAmount] = ISNULL(@CostAmount, [CostAmount]),
            [CurrencyCodeID] = ISNULL(@CurrencyCodeID, [CurrencyCodeID]),
            [ExchangeRate] = ISNULL(@ExchangeRate, [ExchangeRate]),
            [ExchangeRateDate] = CASE WHEN @ExchangeRateDate IS NOT NULL THEN CONVERT(DATE, @ExchangeRateDate) ELSE [ExchangeRateDate] END,
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [PartCostHistoryID] = @PartCostHistoryID;
        
        SET @RowsAffected = @@ROWCOUNT;
        
        RETURN 0;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        SET @RowsAffected = 0;
        RETURN @ErrorNumber;
    END CATCH
END;