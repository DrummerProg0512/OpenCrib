
-- Update procedure for TransactionStatusHistory table
CREATE PROCEDURE [dbo].[usp_TransactionStatusHistory_Update]
    @TransactionStatusHistoryID BIGINT,
    @TransactionID BIGINT = NULL,
    @TransactionStatusID INT = NULL,
    @Notes NVARCHAR(1024) = NULL,
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @TransactionStatusHistoryID IS NULL OR @TransactionStatusHistoryID = 0
        BEGIN
            RAISERROR('TransactionStatusHistoryID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionStatusHistory] WHERE [TransactionStatusHistory] = @TransactionStatusHistoryID)
        BEGIN
            RAISERROR('TransactionStatusHistoryID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @Notes = NULLIF(@Notes, '');
        
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
        
        IF ISNULL(@TransactionStatusID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionStatus] WHERE [TransactionStatusID] = @TransactionStatusID)
            BEGIN
                RAISERROR('TransactionStatusID does not exist in TransactionStatus table.', 16, 1);
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
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[TransactionStatusHistory]
        SET
            [TransactionID] = ISNULL(@TransactionID, [TransactionID]),
            [TransactionStatusID] = ISNULL(@TransactionStatusID, [TransactionStatusID]),
            [Notes] = ISNULL(@Notes, [Notes]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [TransactionStatusHistory] = @TransactionStatusHistoryID;
        
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