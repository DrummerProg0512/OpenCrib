
CREATE PROCEDURE [dbo].[usp_PartStorageLocations_Select]
    @PartStorageLocationID INT = NULL,
    @StorageLocationID INT = NULL,
    @PartID INT = NULL,
    @UpdatedBy INT = NULL,
    @UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            psl.[PartStorageLocationID],
            psl.[StorageLocationID],
            sl.[StorageLocationID] AS [StorageLocationIDRef],
            sl.StorageLocationName,
            psl.[PartID],
            pi.[PartID] AS [PartIDRef],
            pi.[PartName],
            pi.[PartCode],
            psl.[Qty],
            psl.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            psl.[UpdatedOn]
        FROM
            [dbo].[PartStorageLocations] psl
            INNER JOIN [dbo].[StorageLocations] sl ON psl.[StorageLocationID] = sl.[StorageLocationID]
            INNER JOIN [dbo].[PartsItems] pi ON psl.[PartID] = pi.[PartID]
            INNER JOIN [dbo].[Users] u ON psl.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartStorageLocationID, 0) > 0 AND psl.[PartStorageLocationID] = @PartStorageLocationID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartStorageLocationID, 0) = 0
                    AND (ISNULL(@StorageLocationID, 0) = 0 OR psl.[StorageLocationID] = @StorageLocationID)
                    AND (ISNULL(@PartID, 0) = 0 OR psl.[PartID] = @PartID)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR psl.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR psl.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR psl.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            psl.[PartStorageLocationID] DESC;
        
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