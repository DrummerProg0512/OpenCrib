
CREATE PROCEDURE [dbo].[usp_TransactionAttachments_Update]
    @TransactionAttachmentID INT,
    @TransactionID BIGINT = NULL,
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
        IF @TransactionAttachmentID IS NULL OR @TransactionAttachmentID = 0
        BEGIN
            RAISERROR('TransactionAttachmentID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionAttachments] WHERE [TransactionAttachmentID] = @TransactionAttachmentID)
        BEGIN
            RAISERROR('TransactionAttachmentID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
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
        
        IF ISNULL(@TransactionID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
            BEGIN
                RAISERROR('TransactionID does not exist in TransactionHistory table.', 16, 1);
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
        
        -- Normalize empty strings to NULL
        SET @FileDescription = NULLIF(@FileDescription, '');
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[TransactionAttachments]
        SET
            [TransactionID] = ISNULL(@TransactionID, [TransactionID]),
            [ImageData] = ISNULL(@ImageData, [ImageData]),
            [FileName] = ISNULL(@FileName, [FileName]),
            [FileDescription] = ISNULL(@FileDescription, [FileDescription]),
            [FileType] = ISNULL(@FileType, [FileType]),
            [MimeType] = ISNULL(@MimeType, [MimeType]),
            [FileSize] = ISNULL(@FileSize, [FileSize]),
            [ImageActive] = ISNULL(@ImageActive, [ImageActive]),
            [UploadedBy] = ISNULL(@UploadedBy, [UploadedBy])
        WHERE
            [TransactionAttachmentID] = @TransactionAttachmentID;
        
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