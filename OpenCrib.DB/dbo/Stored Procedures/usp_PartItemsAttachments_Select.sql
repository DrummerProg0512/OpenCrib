
create PROCEDURE [dbo].[usp_PartItemsAttachments_Select]
    @PartsItemsAttachmentID INT = NULL,
    @PartID INT = NULL,
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
            pia.[PartsItemsAttachmentID],
            pia.[PartID],
            pi.[PartID] AS [PartIDRef],
            pi.[PartCode],
            pi.[PartName],
            pia.[FileName],
            pia.[FileDescription],
            pia.[FileType],
            pia.[MimeType],
            pia.[FileSize],
            pia.[ImageActive],
            pia.[UploadedBy],
            u.[UserID],
            u.[UserName],
            pia.[UploadedOn]
        FROM
            [dbo].[PartItemsAttachments] pia
            INNER JOIN [dbo].[PartsItems] pi ON pia.[PartID] = pi.[PartID]
            INNER JOIN [dbo].[Users] u ON pia.[UploadedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartsItemsAttachmentID, 0) > 0 AND pia.[PartsItemsAttachmentID] = @PartsItemsAttachmentID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartsItemsAttachmentID, 0) = 0
                    AND (ISNULL(@PartID, 0) = 0 OR pia.[PartID] = @PartID)
                    AND (@FileName IS NULL OR pia.[FileName] LIKE '%' + @FileName + '%')
                    AND (@FileType IS NULL OR pia.[FileType] = @FileType)
                    AND (@ImageActive IS NULL OR pia.[ImageActive] = @ImageActive)
                    AND (ISNULL(@UploadedBy, 0) = 0 OR pia.[UploadedBy] = @UploadedBy)
                    AND (@UploadedOnStartDate IS NULL OR pia.[UploadedOn] >= CONVERT(DATETIME2, @UploadedOnStartDate))
                    AND (@UploadedOnEndDate IS NULL OR pia.[UploadedOn] <= CONVERT(DATETIME2, @UploadedOnEndDate))
                )
            )
        ORDER BY
            pia.[PartsItemsAttachmentID] DESC;
        
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