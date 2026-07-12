-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for TransactionParts table
CREATE PROCEDURE [dbo].[usp_TransactionParts_Insert]
    @TransactionID BIGINT,
    @PartID INT,
    @PartCostHistoryID INT,
    @UnitCost DECIMAL(12, 2),
    @Qty DECIMAL(10, 2),
    @TransactionPartID BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @TransactionID IS NULL OR @TransactionID = 0
        BEGIN
            RAISERROR('TransactionID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartID IS NULL OR @PartID = 0
        BEGIN
            RAISERROR('PartID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartCostHistoryID IS NULL OR @PartCostHistoryID = 0
        BEGIN
            RAISERROR('PartCostHistoryID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
        BEGIN
            RAISERROR('TransactionID does not exist in TransactionHistory table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
        BEGIN
            RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartCostHistory] WHERE [PartCostHistoryID] = @PartCostHistoryID)
        BEGIN
            RAISERROR('PartCostHistoryID does not exist in PartCostHistory table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[TransactionParts]
            ([TransactionID], [PartID], [PartCostHistoryID], [UnitCost], [Qty])
        VALUES
            (@TransactionID, @PartID, @PartCostHistoryID, ISNULL(@UnitCost, 0), ISNULL(@Qty, 0));
        
        -- Return the identity value
        SET @TransactionPartID = SCOPE_IDENTITY();
        
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