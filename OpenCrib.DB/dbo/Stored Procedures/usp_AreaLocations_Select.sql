CREATE PROCEDURE [dbo].[usp_AreaLocations_Select]
    @AreaLocationID INT = NULL,
    @AreaLocationTypeID INT = NULL,
    @AreaLocationName NVARCHAR(250) = NULL,
    @AreaLocationCode NVARCHAR(150) = NULL,
    @AreaLocationActive BIT = NULL,
    @UpdatedBy INT = NULL,
    @UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @AreaLocationName = NULLIF(LTRIM(RTRIM(@AreaLocationName)), '');
        SET @AreaLocationCode = NULLIF(LTRIM(RTRIM(@AreaLocationCode)), '');
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            al.[AreaLocationID],
            al.[AreaLocationTypeID],
            alt.[AreaLocationTypeID] AS [TypeID],
            alt.[AreaLocationTypeName] AS [TypeName],
            al.[AreaLocationName],
            al.[AreaLocationCode],
            al.[AreaLocationDescription],
            al.[AreaLocationActive],
            al.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            al.[UpdatedOn]
        FROM
            [dbo].[AreaLocations] al
            INNER JOIN [dbo].[AreaLocationTypes] alt ON al.[AreaLocationTypeID] = alt.[AreaLocationTypeID]
            INNER JOIN [dbo].[Users] u ON al.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@AreaLocationID, 0) > 0 AND al.[AreaLocationID] = @AreaLocationID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@AreaLocationID, 0) = 0
                    AND (ISNULL(@AreaLocationTypeID, 0) = 0 OR al.[AreaLocationTypeID] = @AreaLocationTypeID)
                    AND (@AreaLocationName IS NULL OR al.[AreaLocationName] LIKE '%' + @AreaLocationName + '%')
                    AND (@AreaLocationCode IS NULL OR al.[AreaLocationCode] LIKE '%' + @AreaLocationCode + '%')
                    AND (@AreaLocationActive IS NULL OR al.[AreaLocationActive] = @AreaLocationActive)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR al.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR al.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR al.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            al.[AreaLocationID];
        
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