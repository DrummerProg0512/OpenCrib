
CREATE PROCEDURE [dbo].[usp_PartUsageTypes_Insert]
    @UsageTypeName NVARCHAR(250),
    @UsageTypeActive BIT = 1,
    @PartUsageTypeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @UsageTypeName IS NULL OR @UsageTypeName = ''
        BEGIN
            RAISERROR('UsageTypeName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[PartUsageTypes]
            ([UsageTypeName], [UsageTypeActive])
        VALUES
            (@UsageTypeName, @UsageTypeActive);
        
        -- Return the identity value
        SET @PartUsageTypeID = SCOPE_IDENTITY();
        
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