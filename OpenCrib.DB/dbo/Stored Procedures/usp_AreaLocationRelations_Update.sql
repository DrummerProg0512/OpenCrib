CREATE PROCEDURE [dbo].[usp_AreaLocationRelations_Update]
    @AreaLocationRelationID INT,
    @AreaLocationParentID INT = NULL,
    @AreaLocationChildID INT = NULL,
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @AreaLocationRelationID IS NULL OR @AreaLocationRelationID = 0
        BEGIN
            RAISERROR('AreaLocationRelationID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocationRelations] WHERE [AreaLocationRelationID] = @AreaLocationRelationID)
        BEGIN
            RAISERROR('AreaLocationRelationID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF ISNULL(@AreaLocationParentID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationParentID)
            BEGIN
                RAISERROR('AreaLocationParentID does not exist in AreaLocations table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@AreaLocationChildID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationChildID)
            BEGIN
                RAISERROR('AreaLocationChildID does not exist in AreaLocations table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UpdatedBy, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
            BEGIN
                RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[AreaLocationRelations]
        SET
            [AreaLocationParentID] = ISNULL(@AreaLocationParentID, [AreaLocationParentID]),
            [AreaLocationChildID] = ISNULL(@AreaLocationChildID, [AreaLocationChildID]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [AreaLocationRelationID] = @AreaLocationRelationID;
        
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