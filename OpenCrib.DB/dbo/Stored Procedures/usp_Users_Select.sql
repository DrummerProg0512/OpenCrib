
-- Select procedure for Users table
CREATE PROCEDURE [dbo].[usp_Users_Select]
    @UserID INT = NULL,
    @UserName NVARCHAR(150) = NULL,
    @UserLastName NVARCHAR(150) = NULL,
    @UserCode NVARCHAR(50) = NULL,
    @UserEmail NVARCHAR(250) = NULL,
    @UserRoleID INT = NULL,
    @UserTypeID INT = NULL,
    @UserActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UserName = NULLIF(@UserName, '');
        SET @UserLastName = NULLIF(@UserLastName, '');
        SET @UserCode = NULLIF(@UserCode, '');
        SET @UserEmail = NULLIF(@UserEmail, '');
        
        SELECT
            u.[UserID],
            u.[UserName],
            u.[UserLastName],
            u.[UserCode],
            u.[EncPassword],
            u.[UserEmail],
            u.[UserActive],
            u.[UserRoleID],
            ur.[UserRoleID] AS [UserRoleIDRef],
            ur.[UserRoleName],
            ur.[UserRoleCode],
            u.[UserTypeID],
            ut.[UserTypeID] AS [UserTypeIDRef],
            ut.[UserTypeName],
            ut.[CostApprovalLevel],
            ut.[CostApprovalAmount],
            ut.[IsActive] AS [UserTypeIsActive]
        FROM
            [dbo].[Users] u
            INNER JOIN [dbo].[UserRoles] ur ON u.[UserRoleID] = ur.[UserRoleID]
            INNER JOIN [dbo].[UserTypes] ut ON u.[UserTypeID] = ut.[UserTypeID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@UserID, 0) > 0 AND u.[UserID] = @UserID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@UserID, 0) = 0
                    AND (@UserName IS NULL OR u.[UserName] = @UserName)
                    AND (@UserLastName IS NULL OR u.[UserLastName] = @UserLastName)
                    AND (@UserCode IS NULL OR u.[UserCode] = @UserCode)
                    AND (@UserEmail IS NULL OR u.[UserEmail] = @UserEmail)
                    AND (ISNULL(@UserRoleID, 0) = 0 OR u.[UserRoleID] = @UserRoleID)
                    AND (ISNULL(@UserTypeID, 0) = 0 OR u.[UserTypeID] = @UserTypeID)
                    AND (@UserActive IS NULL OR u.[UserActive] = @UserActive)
                )
            )
        ORDER BY
            u.[UserID];
        
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