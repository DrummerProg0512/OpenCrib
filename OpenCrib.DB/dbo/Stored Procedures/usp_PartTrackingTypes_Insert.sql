
create PROCEDURE [dbo].[usp_PartTrackingTypes_Insert]
    @TrackingTypeName NVARCHAR(250),
    @TrackingTypeActive BIT = 1,
    @PartTrackingTypeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @TrackingTypeName IS NULL OR @TrackingTypeName = ''
        BEGIN
            RAISERROR('TrackingTypeName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[PartTrackingTypes]
            ([TrackingTypeName], [TrackingTypeActive])
        VALUES
            (@TrackingTypeName, @TrackingTypeActive);
        
        -- Return the identity value
        SET @PartTrackingTypeID = SCOPE_IDENTITY();
        
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