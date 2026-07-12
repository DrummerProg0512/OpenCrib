
-- Update procedure for UserRoles table
CREATE PROCEDURE [dbo].[usp_UserRoles_Update]
    @UserRoleID INT,
    @UserRoleName NVARCHAR(100) = NULL,
    @UserRoleCode NVARCHAR(50) = NULL,
    @UserRoleActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @UserRoleID IS NULL OR @UserRoleID = 0
        BEGIN
            RAISERROR('UserRoleID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UserRoles] WHERE [UserRoleID] = @UserRoleID)
        BEGIN
            RAISERROR('UserRoleID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @UserRoleName = NULLIF(@UserRoleName, '');
        SET @UserRoleCode = NULLIF(@UserRoleCode, '');
        
        -- Validate provided fields
        IF @UserRoleName IS NOT NULL AND @UserRoleName = ''
        BEGIN
            RAISERROR('UserRoleName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @UserRoleCode IS NOT NULL AND @UserRoleCode = ''
        BEGIN
            RAISERROR('UserRoleCode cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[UserRoles]
        SET
            [UserRoleName] = ISNULL(@UserRoleName, [UserRoleName]),
            [UserRoleCode] = ISNULL(@UserRoleCode, [UserRoleCode]),
            [UserRoleActive] = ISNULL(@UserRoleActive, [UserRoleActive])
        WHERE
            [UserRoleID] = @UserRoleID;
        
        SET @RowsAffected = @@ROWCOUNT;
        
        RETURN 0;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        SET @RowsAffected = 0;
        RETURN @ErrorNumber;
    END CATCH
END;