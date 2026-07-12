
-- Select procedure for TransactionStatusHistory table
CREATE PROCEDURE [dbo].[usp_TransactionStatusHistory_Select]
    @TransactionStatusHistoryID BIGINT = NULL,
    @TransactionID BIGINT = NULL,
    @TransactionStatusID INT = NULL,
    @UpdatedBy INT = NULL,
    @UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            tsh.[TransactionStatusHistory],
            tsh.[TransactionID],
            th.[TransactionID] AS [TransactionIDRef],
            tsh.[TransactionStatusID],
            ts.[TransactionStatusID] AS [TransactionStatusIDRef],
            ts.[TransactionStatusName],
            tsh.[Notes],
            tsh.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            tsh.[UpdatedOn]
        FROM
            [dbo].[TransactionStatusHistory] tsh
            INNER JOIN [dbo].[TransactionHistory] th ON tsh.[TransactionID] = th.[TransactionID]
            INNER JOIN [dbo].[TransactionStatus] ts ON tsh.[TransactionStatusID] = ts.[TransactionStatusID]
            INNER JOIN [dbo].[Users] u ON tsh.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@TransactionStatusHistoryID, 0) > 0 AND tsh.[TransactionStatusHistory] = @TransactionStatusHistoryID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@TransactionStatusHistoryID, 0) = 0
                    AND (ISNULL(@TransactionID, 0) = 0 OR tsh.[TransactionID] = @TransactionID)
                    AND (ISNULL(@TransactionStatusID, 0) = 0 OR tsh.[TransactionStatusID] = @TransactionStatusID)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR tsh.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR tsh.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR tsh.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            tsh.[TransactionStatusHistory];
        
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