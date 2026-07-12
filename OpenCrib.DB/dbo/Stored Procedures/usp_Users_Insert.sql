-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for Users table
CREATE PROCEDURE [dbo].[usp_Users_Insert]
    @UserName NVARCHAR(150),
    @UserLastName NVARCHAR(150),
    @UserCode NVARCHAR(50),
    @EncPassword NVARCHAR(500),
    @UserEmail NVARCHAR(250),
    @UserRoleID INT,
    @UserTypeID INT,
    @UserActive BIT = 1,
    @UserID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @UserName IS NULL OR @UserName = ''
        BEGIN
            RAISERROR('UserName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserLastName IS NULL OR @UserLastName = ''
        BEGIN
            RAISERROR('UserLastName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserCode IS NULL OR @UserCode = ''
        BEGIN
            RAISERROR('UserCode is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @EncPassword IS NULL OR @EncPassword = ''
        BEGIN
            RAISERROR('EncPassword is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserEmail IS NULL OR @UserEmail = ''
        BEGIN
            RAISERROR('UserEmail is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserRoleID IS NULL OR @UserRoleID = 0
        BEGIN
            RAISERROR('UserRoleID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserTypeID IS NULL OR @UserTypeID = 0
        BEGIN
            RAISERROR('UserTypeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UserRoles] WHERE [UserRoleID] = @UserRoleID)
        BEGIN
            RAISERROR('UserRoleID does not exist in UserRoles table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UserTypes] WHERE [UserTypeID] = @UserTypeID)
        BEGIN
            RAISERROR('UserTypeID does not exist in UserTypes table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[Users]
            ([UserName], [UserLastName], [UserCode], [EncPassword], [UserEmail], [UserRoleID], [UserTypeID], [UserActive])
        VALUES
            (@UserName, @UserLastName, @UserCode, @EncPassword, @UserEmail, @UserRoleID, @UserTypeID, ISNULL(@UserActive, 1));
        
        -- Return the identity value
        SET @UserID = SCOPE_IDENTITY();
        
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