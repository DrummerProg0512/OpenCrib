
CREATE PROCEDURE [dbo].[usp_TransactionAttachments_Select]
    @TransactionAttachmentID INT = NULL,
    @TransactionID BIGINT = NULL,
    @FileName NVARCHAR(255) = NULL,
    @FileType NVARCHAR(10) = NULL,
    @ImageActive BIT = NULL,
    @UploadedBy INT = NULL,
    @UploadedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UploadedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @FileName = NULLIF(@FileName, '');
        SET @FileType = NULLIF(@FileType, '');
        SET @UploadedOnStartDate = NULLIF(@UploadedOnStartDate, '');
        SET @UploadedOnEndDate = NULLIF(@UploadedOnEndDate, '');
        
        SELECT
            ta.[TransactionAttachmentID],
            ta.[TransactionID],
            th.[TransactionID] AS [TransactionIDRef],
            th.[RequestedBy],
            u2.[UserID] AS [RequestedByUserID],
            u2.[UserName] AS [RequestedByUserName],
            th.[RequestedOn],
            th.[TotalQty],
            th.[TotalCost],
            th.[TransactionTypeID],
            ta.[FileName],
            ta.[FileDescription],
            ta.[FileType],
            ta.[MimeType],
            ta.[FileSize],
            ta.[ImageActive],
            ta.[UploadedBy],
            u.[UserID],
            u.[UserName],
            ta.[UploadedOn]
        FROM
            [dbo].[TransactionAttachments] ta
            INNER JOIN [dbo].[TransactionHistory] th ON ta.[TransactionID] = th.[TransactionID]
            INNER JOIN [dbo].[Users] u ON ta.[UploadedBy] = u.[UserID]
            INNER JOIN [dbo].[Users] u2 ON th.[RequestedBy] = u2.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@TransactionAttachmentID, 0) > 0 AND ta.[TransactionAttachmentID] = @TransactionAttachmentID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@TransactionAttachmentID, 0) = 0
                    AND (ISNULL(@TransactionID, 0) = 0 OR ta.[TransactionID] = @TransactionID)
                    AND (@FileName IS NULL OR ta.[FileName] LIKE '%' + @FileName + '%')
                    AND (@FileType IS NULL OR ta.[FileType] = @FileType)
                    AND (@ImageActive IS NULL OR ta.[ImageActive] = @ImageActive)
                    AND (ISNULL(@UploadedBy, 0) = 0 OR ta.[UploadedBy] = @UploadedBy)
                    AND (@UploadedOnStartDate IS NULL OR ta.[UploadedOn] >= CONVERT(DATETIME2, @UploadedOnStartDate))
                    AND (@UploadedOnEndDate IS NULL OR ta.[UploadedOn] <= CONVERT(DATETIME2, @UploadedOnEndDate))
                )
            )
        ORDER BY
            ta.[TransactionAttachmentID] DESC;
        
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