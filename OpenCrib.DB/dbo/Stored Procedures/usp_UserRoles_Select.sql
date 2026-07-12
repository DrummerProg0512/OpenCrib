
-- Select procedure for UserRoles table
CREATE PROCEDURE [dbo].[usp_UserRoles_Select]
    @UserRoleID INT = NULL,
    @UserRoleName NVARCHAR(100) = NULL,
    @UserRoleCode NVARCHAR(50) = NULL,
    @UserRoleActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UserRoleName = NULLIF(@UserRoleName, '');
        SET @UserRoleCode = NULLIF(@UserRoleCode, '');
        
        SELECT
            ur.[UserRoleID],
            ur.[UserRoleName],
            ur.[UserRoleCode],
            ur.[UserRoleActive]
        FROM
            [dbo].[UserRoles] ur
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@UserRoleID, 0) > 0 AND ur.[UserRoleID] = @UserRoleID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@UserRoleID, 0) = 0
                    AND (@UserRoleName IS NULL OR ur.[UserRoleName] = @UserRoleName)
                    AND (@UserRoleCode IS NULL OR ur.[UserRoleCode] = @UserRoleCode)
                    AND (@UserRoleActive IS NULL OR ur.[UserRoleActive] = @UserRoleActive)
                )
            )
        ORDER BY
            ur.[UserRoleID];
        
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