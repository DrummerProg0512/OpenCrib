
-- Select procedure for TransactionStatus table
CREATE PROCEDURE [dbo].[usp_TransactionStatus_Select]
    @TransactionStatusID INT = NULL,
    @TransactionStatusName NVARCHAR(100) = NULL,
    @TransactionStatusActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @TransactionStatusName = NULLIF(@TransactionStatusName, '');
        
        SELECT
            ts.[TransactionStatusID],
            ts.[TransactionStatusName],
            ts.[TransactionStatusActive]
        FROM
            [dbo].[TransactionStatus] ts
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@TransactionStatusID, 0) > 0 AND ts.[TransactionStatusID] = @TransactionStatusID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@TransactionStatusID, 0) = 0
                    AND (@TransactionStatusName IS NULL OR ts.[TransactionStatusName] = @TransactionStatusName)
                    AND (@TransactionStatusActive IS NULL OR ts.[TransactionStatusActive] = @TransactionStatusActive)
                )
            )
        ORDER BY
            ts.[TransactionStatusID];
        
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