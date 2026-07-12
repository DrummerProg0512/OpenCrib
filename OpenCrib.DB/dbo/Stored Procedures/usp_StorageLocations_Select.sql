
CREATE PROCEDURE [dbo].[usp_StorageLocations_Select]
    @StorageLocationID INT = NULL,
    @StorageLocationTypeID INT = NULL,
    @AreaLocationID INT = NULL,
    @StorageLocationName NVARCHAR(250) = NULL,
    @StorageLocationCode NVARCHAR(150) = NULL,
    @StorageLocationActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @StorageLocationName = NULLIF(@StorageLocationName, '');
        SET @StorageLocationCode = NULLIF(@StorageLocationCode, '');
        
        SELECT
            sl.[StorageLocationID],
            sl.[StorageLocationTypeID],
            slt.[StorageLocationTypeID] AS [StorageLocationTypeIDRef],
            slt.[StorageLocationTypeName],
            sl.[AreaLocationID],
            al.[AreaLocationID] AS [AreaLocationIDRef],
            al.[AreaLocationName],
            sl.[StorageLocationName],
            sl.[StorageLocationCode],
            sl.[StorageLocationDescription],
            sl.[StorageLocationActive]
        FROM
            [dbo].[StorageLocations] sl
            INNER JOIN [dbo].[StorageLocationTypes] slt ON sl.[StorageLocationTypeID] = slt.[StorageLocationTypeID]
            INNER JOIN [dbo].[AreaLocations] al ON sl.[AreaLocationID] = al.[AreaLocationID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@StorageLocationID, 0) > 0 AND sl.[StorageLocationID] = @StorageLocationID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@StorageLocationID, 0) = 0
                    AND (ISNULL(@StorageLocationTypeID, 0) = 0 OR sl.[StorageLocationTypeID] = @StorageLocationTypeID)
                    AND (ISNULL(@AreaLocationID, 0) = 0 OR sl.[AreaLocationID] = @AreaLocationID)
                    AND (@StorageLocationName IS NULL OR sl.[StorageLocationName] LIKE '%' + @StorageLocationName + '%')
                    AND (@StorageLocationCode IS NULL OR sl.[StorageLocationCode] LIKE '%' + @StorageLocationCode + '%')
                    AND (@StorageLocationActive IS NULL OR sl.[StorageLocationActive] = @StorageLocationActive)
                )
            )
        ORDER BY
            sl.[StorageLocationID] DESC;
        
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