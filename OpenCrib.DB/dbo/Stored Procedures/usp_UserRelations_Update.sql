
-- Update procedure for UserRelations table
CREATE PROCEDURE [dbo].[usp_UserRelations_Update]
    @UserRelationID INT,
    @UserID_Parent INT = NULL,
    @UserID_Child INT = NULL,
    @UserRelationActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @UserRelationID IS NULL OR @UserRelationID = 0
        BEGIN
            RAISERROR('UserRelationID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UserRelations] WHERE [UserRelationID] = @UserRelationID)
        BEGIN
            RAISERROR('UserRelationID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided foreign key references
        IF ISNULL(@UserID_Parent, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID_Parent)
            BEGIN
                RAISERROR('UserID_Parent does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UserID_Child, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID_Child)
            BEGIN
                RAISERROR('UserID_Child does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[UserRelations]
        SET
            [UserID_Parent] = ISNULL(@UserID_Parent, [UserID_Parent]),
            [UserID_Child] = ISNULL(@UserID_Child, [UserID_Child]),
            [UserRelationActive] = ISNULL(@UserRelationActive, [UserRelationActive])
        WHERE
            [UserRelationID] = @UserRelationID;
        
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