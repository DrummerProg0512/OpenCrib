
CREATE PROCEDURE [dbo].[usp_PartTypeCategory_Update]
    @PartTypeCategoryID INT,
    @PartTypeName NVARCHAR(150) = NULL,
    @PartTypeActive BIT = NULL,
    @PartTypeDescription NVARCHAR(1050) = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartTypeCategoryID IS NULL OR @PartTypeCategoryID = 0
        BEGIN
            RAISERROR('PartTypeCategoryID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartTypeCategory] WHERE [PartTypeCategoryID] = @PartTypeCategoryID)
        BEGIN
            RAISERROR('PartTypeCategoryID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @PartTypeName = ''
        BEGIN
            RAISERROR('PartTypeName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @PartTypeDescription = ''
        BEGIN
            RAISERROR('PartTypeDescription cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[PartTypeCategory]
        SET
            [PartTypeName] = ISNULL(@PartTypeName, [PartTypeName]),
            [PartTypeActive] = ISNULL(@PartTypeActive, [PartTypeActive]),
            [PartTypeDescription] = ISNULL(@PartTypeDescription, [PartTypeDescription])
        WHERE
            [PartTypeCategoryID] = @PartTypeCategoryID;
        
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