
CREATE PROCEDURE [dbo].[usp_PartCostHistory_Insert]
    @PartID INT,
    @CostAmount DECIMAL(12, 2),
    @CurrencyCodeID INT,
    @ExchangeRate DECIMAL(12, 2),
    @ExchangeRateDate VARCHAR(10),  -- Format: 'YYYY-MM-DD'
    @UpdatedBy INT,
    @PartCostHistoryID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @PartID IS NULL OR @PartID = 0
        BEGIN
            RAISERROR('PartID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @CostAmount IS NULL OR @CostAmount <= 0
        BEGIN
            RAISERROR('CostAmount is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @CurrencyCodeID IS NULL OR @CurrencyCodeID = 0
        BEGIN
            RAISERROR('CurrencyCodeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @ExchangeRate IS NULL OR @ExchangeRate <= 0
        BEGIN
            RAISERROR('ExchangeRate is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @ExchangeRateDate IS NULL OR @ExchangeRateDate = ''
        BEGIN
            RAISERROR('ExchangeRateDate is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
        BEGIN
            RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[CurrencyCodes] WHERE [CurrencyCodeID] = @CurrencyCodeID)
        BEGIN
            RAISERROR('CurrencyCodeID does not exist in CurrencyCodes table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[PartCostHistory]
            ([PartID], [CostAmount], [CurrencyCodeID], [ExchangeRate], 
             [ExchangeRateDate], [UpdatedBy])
        VALUES
            (@PartID, @CostAmount, @CurrencyCodeID, @ExchangeRate, 
             CONVERT(DATE, @ExchangeRateDate), @UpdatedBy);
        
        -- Return the identity value
        SET @PartCostHistoryID = SCOPE_IDENTITY();
        
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