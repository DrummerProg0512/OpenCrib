
CREATE PROCEDURE [dbo].[usp_PartAssetsAttachments_Select]
    @PartAssetsAttachmentID INT = NULL,
    @AssetID BIGINT = NULL,
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
            paa.[PartAssetsAttachmentID],
            paa.[AssetID],
            pa.[AssetID] AS [AssetIDRef],
            pa.[SerialNumber],
            pa.[AssetTag],
            paa.[FileName],
            paa.[FileDescription],
            paa.[FileType],
            paa.[MimeType],
            paa.[FileSize],
            paa.[ImageActive],
            paa.[UploadedBy],
            u.[UserID],
            u.[UserName],
            paa.[UploadedOn]
        FROM
            [dbo].[PartAssetsAttachments] paa
            INNER JOIN [dbo].[PartAssets] pa ON paa.[AssetID] = pa.[AssetID]
            INNER JOIN [dbo].[Users] u ON paa.[UploadedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartAssetsAttachmentID, 0) > 0 AND paa.[PartAssetsAttachmentID] = @PartAssetsAttachmentID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartAssetsAttachmentID, 0) = 0
                    AND (ISNULL(@AssetID, 0) = 0 OR paa.[AssetID] = @AssetID)
                    AND (@FileName IS NULL OR paa.[FileName] LIKE '%' + @FileName + '%')
                    AND (@FileType IS NULL OR paa.[FileType] = @FileType)
                    AND (@ImageActive IS NULL OR paa.[ImageActive] = @ImageActive)
                    AND (ISNULL(@UploadedBy, 0) = 0 OR paa.[UploadedBy] = @UploadedBy)
                    AND (@UploadedOnStartDate IS NULL OR paa.[UploadedOn] >= CONVERT(DATETIME2, @UploadedOnStartDate))
                    AND (@UploadedOnEndDate IS NULL OR paa.[UploadedOn] <= CONVERT(DATETIME2, @UploadedOnEndDate))
                )
            )
        ORDER BY
            paa.[PartAssetsAttachmentID] DESC;
        
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