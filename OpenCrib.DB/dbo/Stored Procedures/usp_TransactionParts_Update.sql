
-- Update procedure for TransactionParts table
CREATE PROCEDURE [dbo].[usp_TransactionParts_Update]
    @TransactionPartID BIGINT,
    @TransactionID BIGINT = NULL,
    @PartID INT = NULL,
    @PartCostHistoryID INT = NULL,
    @UnitCost DECIMAL(12, 2) = NULL,
    @Qty DECIMAL(10, 2) = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @TransactionPartID IS NULL OR @TransactionPartID = 0
        BEGIN
            RAISERROR('TransactionPartID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionParts] WHERE [TransactionPartID] = @TransactionPartID)
        BEGIN
            RAISERROR('TransactionPartID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided foreign key references
        IF ISNULL(@TransactionID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
            BEGIN
                RAISERROR('TransactionID does not exist in TransactionHistory table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@PartID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
            BEGIN
                RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@PartCostHistoryID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartCostHistory] WHERE [PartCostHistoryID] = @PartCostHistoryID)
            BEGIN
                RAISERROR('PartCostHistoryID does not exist in PartCostHistory table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[TransactionParts]
        SET
            [TransactionID] = ISNULL(@TransactionID, [TransactionID]),
            [PartID] = ISNULL(@PartID, [PartID]),
            [PartCostHistoryID] = ISNULL(@PartCostHistoryID, [PartCostHistoryID]),
            [UnitCost] = ISNULL(@UnitCost, [UnitCost]),
            [Qty] = ISNULL(@Qty, [Qty])
        WHERE
            [TransactionPartID] = @TransactionPartID;
        
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