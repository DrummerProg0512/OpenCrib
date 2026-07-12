
CREATE PROCEDURE [dbo].[usp_TransactionHistory_Select]
    @TransactionID BIGINT = NULL,
    @RequestedBy INT = NULL,
    @TransactionTypeID INT = NULL,
    @RequestedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @RequestedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @RequestedOnStartDate = NULLIF(@RequestedOnStartDate, '');
        SET @RequestedOnEndDate = NULLIF(@RequestedOnEndDate, '');
        
        SELECT
            th.[TransactionID],
            th.[RequestedBy],
            u.[UserID],
            u.[UserName],
            th.[RequestedOn],
            th.[TotalQty],
            th.[TotalCost],
            th.[TransactionTypeID],
            ts.[TransactionStatusID],
            ts.[TransactionStatusName]
        FROM
            [dbo].[TransactionHistory] th
            INNER JOIN [dbo].[Users] u ON th.[RequestedBy] = u.[UserID]
            INNER JOIN [dbo].[TransactionStatus] ts ON th.[TransactionTypeID] = ts.[TransactionStatusID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@TransactionID, 0) > 0 AND th.[TransactionID] = @TransactionID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@TransactionID, 0) = 0
                    AND (ISNULL(@RequestedBy, 0) = 0 OR th.[RequestedBy] = @RequestedBy)
                    AND (ISNULL(@TransactionTypeID, 0) = 0 OR th.[TransactionTypeID] = @TransactionTypeID)
                    AND (@RequestedOnStartDate IS NULL OR th.[RequestedOn] >= CONVERT(DATETIME2, @RequestedOnStartDate))
                    AND (@RequestedOnEndDate IS NULL OR th.[RequestedOn] <= CONVERT(DATETIME2, @RequestedOnEndDate))
                )
            )
        ORDER BY
            th.[TransactionID] DESC;
        
        RETURN 0;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN @ErrorMessage;
    END CATCH
END;