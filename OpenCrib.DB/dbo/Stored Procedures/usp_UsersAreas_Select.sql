
-- Select procedure for UsersAreas table
CREATE PROCEDURE [dbo].[usp_UsersAreas_Select]
    @UsersAreasID INT = NULL,
    @AreaLocationID INT = NULL,
    @UserID INT = NULL,
    @UpdatedBy INT = NULL,
    @UpdatedOnStartDate VARCHAR(27) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss.fff'
    @UpdatedOnEndDate VARCHAR(27) = NULL,    -- Format: 'YYYY-MM-DD HH:mm:ss.fff'
    @UsersAreaActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            ua.[UsersAreasID],
            ua.[AreaLocationID],
            al.[AreaLocationID] AS [AreaLocationIDRef],
            al.[AreaLocationName],
            ua.[UserID],
            u.[UserID] AS [UserIDRef],
            u.[UserName],
            u.[UserLastName],
            ua.[UpdatedOn],
            ua.[UpdatedBy],
            uu.[UserID] AS [UpdatedByUserIDRef],
            uu.[UserName] AS [UpdatedByUserName],
            ua.[UsersAreaActive]
        FROM
            [dbo].[UsersAreas] ua
            INNER JOIN [dbo].[AreaLocations] al ON ua.[AreaLocationID] = al.[AreaLocationID]
            INNER JOIN [dbo].[Users] u ON ua.[UserID] = u.[UserID]
            INNER JOIN [dbo].[Users] uu ON ua.[UpdatedBy] = uu.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@UsersAreasID, 0) > 0 AND ua.[UsersAreasID] = @UsersAreasID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@UsersAreasID, 0) = 0
                    AND (ISNULL(@AreaLocationID, 0) = 0 OR ua.[AreaLocationID] = @AreaLocationID)
                    AND (ISNULL(@UserID, 0) = 0 OR ua.[UserID] = @UserID)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR ua.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR ua.[UpdatedOn] >= CONVERT(DATETIME2(7), @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR ua.[UpdatedOn] <= CONVERT(DATETIME2(7), @UpdatedOnEndDate))
                    AND (@UsersAreaActive IS NULL OR ua.[UsersAreaActive] = @UsersAreaActive)
                )
            )
        ORDER BY
            ua.[UsersAreasID];
        
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