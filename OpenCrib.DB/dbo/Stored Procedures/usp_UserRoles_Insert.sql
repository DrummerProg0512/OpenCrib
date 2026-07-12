-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for UserRoles table
CREATE PROCEDURE [dbo].[usp_UserRoles_Insert]
    @UserRoleName NVARCHAR(100),
    @UserRoleCode NVARCHAR(50),
    @UserRoleActive BIT = 1,
    @UserRoleID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @UserRoleName IS NULL OR @UserRoleName = ''
        BEGIN
            RAISERROR('UserRoleName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserRoleCode IS NULL OR @UserRoleCode = ''
        BEGIN
            RAISERROR('UserRoleCode is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[UserRoles]
            ([UserRoleName], [UserRoleCode], [UserRoleActive])
        VALUES
            (@UserRoleName, @UserRoleCode, ISNULL(@UserRoleActive, 1));
        
        -- Return the identity value
        SET @UserRoleID = SCOPE_IDENTITY();
        
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