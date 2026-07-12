CREATE PROCEDURE [dbo].[usp_AreaLocationRelations_Insert]
    @AreaLocationParentID INT,
    @AreaLocationChildID INT,
    @UpdatedBy INT,
    @AreaLocationRelationID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @AreaLocationParentID IS NULL OR @AreaLocationParentID = 0
        BEGIN
            RAISERROR('AreaLocationParentID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @AreaLocationChildID IS NULL OR @AreaLocationChildID = 0
        BEGIN
            RAISERROR('AreaLocationChildID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationParentID)
        BEGIN
            RAISERROR('AreaLocationParentID does not exist in AreaLocations table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationChildID)
        BEGIN
            RAISERROR('AreaLocationChildID does not exist in AreaLocations table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[AreaLocationRelations]
            ([AreaLocationParentID], [AreaLocationChildID], [UpdatedBy])
        VALUES
            (@AreaLocationParentID, @AreaLocationChildID, @UpdatedBy);
        
        -- Return the identity value
        SET @AreaLocationRelationID = SCOPE_IDENTITY();
        
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