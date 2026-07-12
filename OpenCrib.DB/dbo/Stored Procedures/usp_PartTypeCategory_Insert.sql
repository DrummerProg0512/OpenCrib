
CREATE PROCEDURE [dbo].[usp_PartTypeCategory_Insert]
    @PartTypeCategoryID INT,
    @PartTypeName NVARCHAR(150),
    @PartTypeActive BIT = 1,
    @PartTypeDescription NVARCHAR(1050)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @PartTypeCategoryID IS NULL OR @PartTypeCategoryID = 0
        BEGIN
            RAISERROR('PartTypeCategoryID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartTypeName IS NULL OR @PartTypeName = ''
        BEGIN
            RAISERROR('PartTypeName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartTypeDescription IS NULL OR @PartTypeDescription = ''
        BEGIN
            RAISERROR('PartTypeDescription is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Check if record already exists
        IF EXISTS (SELECT 1 FROM [dbo].[PartTypeCategory] WHERE [PartTypeCategoryID] = @PartTypeCategoryID)
        BEGIN
            RAISERROR('PartTypeCategoryID already exists.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[PartTypeCategory]
            ([PartTypeCategoryID], [PartTypeName], [PartTypeActive], [PartTypeDescription])
        VALUES
            (@PartTypeCategoryID, @PartTypeName, @PartTypeActive, @PartTypeDescription);
        
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