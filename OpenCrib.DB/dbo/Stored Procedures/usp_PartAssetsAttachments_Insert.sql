
CREATE PROCEDURE [dbo].[usp_PartAssetsAttachments_Insert]
    @AssetID BIGINT,
    @ImageData VARBINARY(MAX),
    @FileName NVARCHAR(255),
    @FileDescription NVARCHAR(500) = '',
    @FileType NVARCHAR(10),
    @MimeType NVARCHAR(50),
    @FileSize INT,
    @ImageActive BIT = 1,
    @UploadedBy INT,
    @PartAssetsAttachmentID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @AssetID IS NULL OR @AssetID = 0
        BEGIN
            RAISERROR('AssetID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @ImageData IS NULL OR DATALENGTH(@ImageData) = 0
        BEGIN
            RAISERROR('ImageData is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @FileName IS NULL OR @FileName = ''
        BEGIN
            RAISERROR('FileName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @FileType IS NULL OR @FileType = ''
        BEGIN
            RAISERROR('FileType is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @MimeType IS NULL OR @MimeType = ''
        BEGIN
            RAISERROR('MimeType is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @FileSize IS NULL OR @FileSize <= 0
        BEGIN
            RAISERROR('FileSize is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UploadedBy IS NULL OR @UploadedBy = 0
        BEGIN
            RAISERROR('UploadedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartAssets] WHERE [AssetID] = @AssetID)
        BEGIN
            RAISERROR('AssetID does not exist in PartAssets table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UploadedBy)
        BEGIN
            RAISERROR('UploadedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @FileDescription = NULLIF(@FileDescription, '');
        
        -- Insert the record
        INSERT INTO [dbo].[PartAssetsAttachments]
            ([AssetID], [ImageData], [FileName], [FileDescription], [FileType], 
             [MimeType], [FileSize], [ImageActive], [UploadedBy])
        VALUES
            (@AssetID, @ImageData, @FileName, @FileDescription, @FileType, 
             @MimeType, @FileSize, @ImageActive, @UploadedBy);
        
        -- Return the identity value
        SET @PartAssetsAttachmentID = SCOPE_IDENTITY();
        
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