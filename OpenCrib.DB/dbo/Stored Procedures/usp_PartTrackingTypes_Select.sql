
create PROCEDURE [dbo].[usp_PartTrackingTypes_Select]
    @PartTrackingTypeID INT = NULL,
    @TrackingTypeName NVARCHAR(250) = NULL,
    @TrackingTypeActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @TrackingTypeName = NULLIF(@TrackingTypeName, '');
        
        SELECT
            ptt.[PartTrackingTypeID],
            ptt.[TrackingTypeName],
            ptt.[TrackingTypeActive]
        FROM
            [dbo].[PartTrackingTypes] ptt
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartTrackingTypeID, 0) > 0 AND ptt.[PartTrackingTypeID] = @PartTrackingTypeID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartTrackingTypeID, 0) = 0
                    AND (@TrackingTypeName IS NULL OR ptt.[TrackingTypeName] LIKE '%' + @TrackingTypeName + '%')
                    AND (@TrackingTypeActive IS NULL OR ptt.[TrackingTypeActive] = @TrackingTypeActive)
                )
            )
        ORDER BY
            ptt.[PartTrackingTypeID] DESC;
        
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