
-- Update procedure for Users table
CREATE PROCEDURE [dbo].[usp_Users_Update]
    @UserID INT,
    @UserName NVARCHAR(150) = NULL,
    @UserLastName NVARCHAR(150) = NULL,
    @UserCode NVARCHAR(50) = NULL,
    @EncPassword NVARCHAR(500) = NULL,
    @UserEmail NVARCHAR(250) = NULL,
    @UserRoleID INT = NULL,
    @UserTypeID INT = NULL,
    @UserActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @UserID IS NULL OR @UserID = 0
        BEGIN
            RAISERROR('UserID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID)
        BEGIN
            RAISERROR('UserID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @UserName = NULLIF(@UserName, '');
        SET @UserLastName = NULLIF(@UserLastName, '');
        SET @UserCode = NULLIF(@UserCode, '');
        SET @EncPassword = NULLIF(@EncPassword, '');
        SET @UserEmail = NULLIF(@UserEmail, '');
        
        -- Validate provided fields
        IF @UserName IS NOT NULL AND @UserName = ''
        BEGIN
            RAISERROR('UserName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @UserLastName IS NOT NULL AND @UserLastName = ''
        BEGIN
            RAISERROR('UserLastName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @UserCode IS NOT NULL AND @UserCode = ''
        BEGIN
            RAISERROR('UserCode cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @EncPassword IS NOT NULL AND @EncPassword = ''
        BEGIN
            RAISERROR('EncPassword cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @UserEmail IS NOT NULL AND @UserEmail = ''
        BEGIN
            RAISERROR('UserEmail cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided foreign key references
        IF ISNULL(@UserRoleID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[UserRoles] WHERE [UserRoleID] = @UserRoleID)
            BEGIN
                RAISERROR('UserRoleID does not exist in UserRoles table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UserTypeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[UserTypes] WHERE [UserTypeID] = @UserTypeID)
            BEGIN
                RAISERROR('UserTypeID does not exist in UserTypes table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[Users]
        SET
            [UserName] = ISNULL(@UserName, [UserName]),
            [UserLastName] = ISNULL(@UserLastName, [UserLastName]),
            [UserCode] = ISNULL(@UserCode, [UserCode]),
            [EncPassword] = ISNULL(@EncPassword, [EncPassword]),
            [UserEmail] = ISNULL(@UserEmail, [UserEmail]),
            [UserRoleID] = ISNULL(@UserRoleID, [UserRoleID]),
            [UserTypeID] = ISNULL(@UserTypeID, [UserTypeID]),
            [UserActive] = ISNULL(@UserActive, [UserActive])
        WHERE
            [UserID] = @UserID;
        
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