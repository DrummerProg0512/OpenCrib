-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for TransactionStatus table
CREATE PROCEDURE [dbo].[usp_TransactionStatus_Insert]
    @TransactionStatusName NVARCHAR(100),
    @TransactionStatusActive BIT = 1,
    @TransactionStatusID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @TransactionStatusName IS NULL OR @TransactionStatusName = ''
        BEGIN
            RAISERROR('TransactionStatusName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[TransactionStatus]
            ([TransactionStatusName], [TransactionStatusActive])
        VALUES
            (@TransactionStatusName, ISNULL(@TransactionStatusActive, 1));
        
        -- Return the identity value
        SET @TransactionStatusID = SCOPE_IDENTITY();
        
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