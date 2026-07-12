CREATE PROCEDURE [dbo].[usp_AreaLocationRelations_Select]
    @AreaLocationRelationID INT = NULL,
    @AreaLocationParentID INT = NULL,
    @AreaLocationChildID INT = NULL,
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
            alr.[AreaLocationRelationID],
            alr.[AreaLocationParentID],
            alrParent.[AreaLocationID] AS [ParentAreaLocationID],
            alrParent.[AreaLocationName] AS [ParentLocationName],
            alr.[AreaLocationChildID],
            alrChild.[AreaLocationID] AS [ChildAreaLocationID],
            alrChild.[AreaLocationName] AS [ChildLocationName],
            alr.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            alr.[UpdatedOn]
        FROM
            [dbo].[AreaLocationRelations] alr
            INNER JOIN [dbo].[AreaLocations] alrParent ON alr.[AreaLocationParentID] = alrParent.[AreaLocationID]
            INNER JOIN [dbo].[AreaLocations] alrChild ON alr.[AreaLocationChildID] = alrChild.[AreaLocationID]
            INNER JOIN [dbo].[Users] u ON alr.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@AreaLocationRelationID, 0) > 0 AND alr.[AreaLocationRelationID] = @AreaLocationRelationID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@AreaLocationRelationID, 0) = 0
                    AND (ISNULL(@AreaLocationParentID, 0) = 0 OR alr.[AreaLocationParentID] = @AreaLocationParentID)
                    AND (ISNULL(@AreaLocationChildID, 0) = 0 OR alr.[AreaLocationChildID] = @AreaLocationChildID)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR alr.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR alr.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR alr.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            alr.[AreaLocationRelationID];
        
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