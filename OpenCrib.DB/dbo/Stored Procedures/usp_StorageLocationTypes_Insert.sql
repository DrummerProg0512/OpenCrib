
CREATE PROCEDURE [dbo].[usp_StorageLocationTypes_Insert]
    @StorageLocationTypeName NVARCHAR(150),
    @StorageLocationTypeActive BIT = 1,
    @StorageLocationTypeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @StorageLocationTypeName IS NULL OR @StorageLocationTypeName = ''
        BEGIN
            RAISERROR('StorageLocationTypeName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[StorageLocationTypes]
            ([StorageLocationTypeName], [StorageLocationTypeActive])
        VALUES
            (@StorageLocationTypeName, @StorageLocationTypeActive);
        
        -- Return the identity value
        SET @StorageLocationTypeID = SCOPE_IDENTITY();
        
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