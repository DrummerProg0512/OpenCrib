
-- Update procedure for TransactionStatus table
CREATE PROCEDURE [dbo].[usp_TransactionStatus_Update]
    @TransactionStatusID INT,
    @TransactionStatusName NVARCHAR(100) = NULL,
    @TransactionStatusActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @TransactionStatusID IS NULL OR @TransactionStatusID = 0
        BEGIN
            RAISERROR('TransactionStatusID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionStatus] WHERE [TransactionStatusID] = @TransactionStatusID)
        BEGIN
            RAISERROR('TransactionStatusID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @TransactionStatusName = NULLIF(@TransactionStatusName, '');
        
        -- Validate provided fields
        IF @TransactionStatusName IS NOT NULL AND @TransactionStatusName = ''
        BEGIN
            RAISERROR('TransactionStatusName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[TransactionStatus]
        SET
            [TransactionStatusName] = ISNULL(@TransactionStatusName, [TransactionStatusName]),
            [TransactionStatusActive] = ISNULL(@TransactionStatusActive, [TransactionStatusActive])
        WHERE
            [TransactionStatusID] = @TransactionStatusID;
        
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