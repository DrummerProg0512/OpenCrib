
CREATE PROCEDURE [dbo].[usp_StorageLocations_Update]
    @StorageLocationID INT,
    @StorageLocationTypeID INT = NULL,
    @AreaLocationID INT = NULL,
    @StorageLocationName NVARCHAR(250) = NULL,
    @StorageLocationCode NVARCHAR(150) = NULL,
    @StorageLocationDescription NVARCHAR(500) = NULL,
    @StorageLocationActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @StorageLocationID IS NULL OR @StorageLocationID = 0
        BEGIN
            RAISERROR('StorageLocationID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[StorageLocations] WHERE [StorageLocationID] = @StorageLocationID)
        BEGIN
            RAISERROR('StorageLocationID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @StorageLocationName = ''
        BEGIN
            RAISERROR('StorageLocationName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @StorageLocationCode = ''
        BEGIN
            RAISERROR('StorageLocationCode cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @StorageLocationDescription = ''
        BEGIN
            RAISERROR('StorageLocationDescription cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF ISNULL(@StorageLocationTypeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[StorageLocationTypes] WHERE [StorageLocationTypeID] = @StorageLocationTypeID)
            BEGIN
                RAISERROR('StorageLocationTypeID does not exist in StorageLocationTypes table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@AreaLocationID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationID)
            BEGIN
                RAISERROR('AreaLocationID does not exist in AreaLocations table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[StorageLocations]
        SET
            [StorageLocationTypeID] = ISNULL(@StorageLocationTypeID, [StorageLocationTypeID]),
            [AreaLocationID] = ISNULL(@AreaLocationID, [AreaLocationID]),
            [StorageLocationName] = ISNULL(@StorageLocationName, [StorageLocationName]),
            [StorageLocationCode] = ISNULL(@StorageLocationCode, [StorageLocationCode]),
            [StorageLocationDescription] = ISNULL(@StorageLocationDescription, [StorageLocationDescription]),
            [StorageLocationActive] = ISNULL(@StorageLocationActive, [StorageLocationActive])
        WHERE
            [StorageLocationID] = @StorageLocationID;
        
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