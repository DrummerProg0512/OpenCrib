
create PROCEDURE [dbo].[usp_PartItemsAttachments_Update]
    @PartsItemsAttachmentID INT,
    @PartID INT = NULL,
    @ImageData VARBINARY(MAX) = NULL,
    @FileName NVARCHAR(255) = NULL,
    @FileDescription NVARCHAR(500) = NULL,
    @FileType NVARCHAR(10) = NULL,
    @MimeType NVARCHAR(50) = NULL,
    @FileSize INT = NULL,
    @ImageActive BIT = NULL,
    @UploadedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartsItemsAttachmentID IS NULL OR @PartsItemsAttachmentID = 0
        BEGIN
            RAISERROR('PartsItemsAttachmentID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartItemsAttachments] WHERE [PartsItemsAttachmentID] = @PartsItemsAttachmentID)
        BEGIN
            RAISERROR('PartsItemsAttachmentID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF ISNULL(@PartID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
            BEGIN
                RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UploadedBy, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UploadedBy)
            BEGIN
                RAISERROR('UploadedBy does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Validate string fields are not empty when provided
        IF @FileName = ''
        BEGIN
            RAISERROR('FileName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @FileType = ''
        BEGIN
            RAISERROR('FileType cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @MimeType = ''
        BEGIN
            RAISERROR('MimeType cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @FileDescription = NULLIF(@FileDescription, '');
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[PartItemsAttachments]
        SET
            [PartID] = ISNULL(@PartID, [PartID]),
            [ImageData] = ISNULL(@ImageData, [ImageData]),
            [FileName] = ISNULL(@FileName, [FileName]),
            [FileDescription] = ISNULL(@FileDescription, [FileDescription]),
            [FileType] = ISNULL(@FileType, [FileType]),
            [MimeType] = ISNULL(@MimeType, [MimeType]),
            [FileSize] = ISNULL(@FileSize, [FileSize]),
            [ImageActive] = ISNULL(@ImageActive, [ImageActive]),
            [UploadedBy] = ISNULL(@UploadedBy, [UploadedBy])
        WHERE
            [PartsItemsAttachmentID] = @PartsItemsAttachmentID;
        
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