CREATE PROCEDURE [dbo].[usp_AreaLocationTypes_Insert]
    @AreaLocationTypeName NVARCHAR(150),
    @AreaLocationTypeActive BIT = 1,
    @AreaLocationTypeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @AreaLocationTypeName = NULLIF(LTRIM(RTRIM(@AreaLocationTypeName)), '');
        
        -- Validate required fields
        IF @AreaLocationTypeName IS NULL
        BEGIN
            RAISERROR('AreaLocationTypeName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[AreaLocationTypes]
            ([AreaLocationTypeName], [AreaLocationTypeActive])
        VALUES
            (@AreaLocationTypeName, @AreaLocationTypeActive);
        
        -- Return the identity value
        SET @AreaLocationTypeID = SCOPE_IDENTITY();
        
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