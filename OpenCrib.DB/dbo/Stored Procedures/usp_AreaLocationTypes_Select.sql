-- Created by GitHub Copilot in SSMS - review carefully before executing
CREATE PROCEDURE [dbo].[usp_AreaLocationTypes_Select]
    @AreaLocationTypeID INT = NULL,
    @AreaLocationTypeName NVARCHAR(150) = NULL,
    @AreaLocationTypeActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @AreaLocationTypeName = NULLIF(LTRIM(RTRIM(@AreaLocationTypeName)), '');
        
        SELECT
            [AreaLocationTypeID],
            [AreaLocationTypeName],
            [AreaLocationTypeActive]
        FROM
            [dbo].[AreaLocationTypes]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@AreaLocationTypeID, 0) > 0 AND [AreaLocationTypeID] = @AreaLocationTypeID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@AreaLocationTypeID, 0) = 0
                    AND (@AreaLocationTypeName IS NULL OR [AreaLocationTypeName] LIKE '%' + @AreaLocationTypeName + '%')
                    AND (@AreaLocationTypeActive IS NULL OR [AreaLocationTypeActive] = @AreaLocationTypeActive)
                )
            )
        ORDER BY
            [AreaLocationTypeID];
        
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