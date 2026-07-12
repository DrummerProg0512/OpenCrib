
CREATE PROCEDURE [dbo].[usp_TransactionHistory_Update]
    @TransactionID BIGINT,
    @RequestedBy INT = NULL,
    @TotalQty INT = NULL,
    @TotalCost DECIMAL(12, 2) = NULL,
    @TransactionTypeID INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @TransactionID IS NULL OR @TransactionID = 0
        BEGIN
            RAISERROR('TransactionID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
        BEGIN
            RAISERROR('TransactionID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF ISNULL(@RequestedBy, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @RequestedBy)
            BEGIN
                RAISERROR('RequestedBy does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@TransactionTypeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionStatus] WHERE [TransactionStatusID] = @TransactionTypeID)
            BEGIN
                RAISERROR('TransactionTypeID does not exist in TransactionStatus table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[TransactionHistory]
        SET
            [RequestedBy] = ISNULL(@RequestedBy, [RequestedBy]),
            [TotalQty] = ISNULL(@TotalQty, [TotalQty]),
            [TotalCost] = ISNULL(@TotalCost, [TotalCost]),
            [TransactionTypeID] = ISNULL(@TransactionTypeID, [TransactionTypeID])
        WHERE
            [TransactionID] = @TransactionID;
        
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