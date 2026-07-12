-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for TransactionStatusHistory table
CREATE PROCEDURE [dbo].[usp_TransactionStatusHistory_Insert]
    @TransactionID BIGINT,
    @TransactionStatusID INT,
    @Notes NVARCHAR(1024) = NULL,
    @UpdatedBy INT,
    @TransactionStatusHistoryID BIGINT OUTPUT
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
        
        IF @TransactionStatusID IS NULL OR @TransactionStatusID = 0
        BEGIN
            RAISERROR('TransactionStatusID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
        BEGIN
            RAISERROR('TransactionID does not exist in TransactionHistory table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionStatus] WHERE [TransactionStatusID] = @TransactionStatusID)
        BEGIN
            RAISERROR('TransactionStatusID does not exist in TransactionStatus table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @Notes = NULLIF(@Notes, '');
        
        -- Insert the record
        INSERT INTO [dbo].[TransactionStatusHistory]
            ([TransactionID], [TransactionStatusID], [Notes], [UpdatedBy], [UpdatedOn])
        VALUES
            (@TransactionID, @TransactionStatusID, @Notes, @UpdatedBy, GETDATE());
        
        -- Return the identity value
        SET @TransactionStatusHistoryID = SCOPE_IDENTITY();
        
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