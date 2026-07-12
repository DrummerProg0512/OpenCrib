
create PROCEDURE [dbo].[usp_PartTrackingTypes_Update]
    @PartTrackingTypeID INT,
    @TrackingTypeName NVARCHAR(250) = NULL,
    @TrackingTypeActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartTrackingTypeID IS NULL OR @PartTrackingTypeID = 0
        BEGIN
            RAISERROR('PartTrackingTypeID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartTrackingTypes] WHERE [PartTrackingTypeID] = @PartTrackingTypeID)
        BEGIN
            RAISERROR('PartTrackingTypeID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @TrackingTypeName = ''
        BEGIN
            RAISERROR('TrackingTypeName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[PartTrackingTypes]
        SET
            [TrackingTypeName] = ISNULL(@TrackingTypeName, [TrackingTypeName]),
            [TrackingTypeActive] = ISNULL(@TrackingTypeActive, [TrackingTypeActive])
        WHERE
            [PartTrackingTypeID] = @PartTrackingTypeID;
        
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