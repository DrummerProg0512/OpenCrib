-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for UserRelations table
CREATE PROCEDURE [dbo].[usp_UserRelations_Insert]
    @UserID_Parent INT,
    @UserID_Child INT,
    @UserRelationActive BIT = 1,
    @UserRelationID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @UserID_Parent IS NULL OR @UserID_Parent = 0
        BEGIN
            RAISERROR('UserID_Parent is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserID_Child IS NULL OR @UserID_Child = 0
        BEGIN
            RAISERROR('UserID_Child is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID_Parent)
        BEGIN
            RAISERROR('UserID_Parent does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID_Child)
        BEGIN
            RAISERROR('UserID_Child does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[UserRelations]
            ([UserID_Parent], [UserID_Child], [UserRelationActive])
        VALUES
            (@UserID_Parent, @UserID_Child, ISNULL(@UserRelationActive, 1));
        
        -- Return the identity value
        SET @UserRelationID = SCOPE_IDENTITY();
        
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