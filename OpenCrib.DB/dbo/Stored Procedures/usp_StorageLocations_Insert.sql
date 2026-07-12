
create PROCEDURE [dbo].[usp_StorageLocations_Insert]
    @StorageLocationTypeID INT,
    @AreaLocationID INT,
    @StorageLocationName NVARCHAR(250),
    @StorageLocationCode NVARCHAR(150),
    @StorageLocationDescription NVARCHAR(500),
    @StorageLocationActive BIT = 1,
    @StorageLocationID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @StorageLocationTypeID IS NULL OR @StorageLocationTypeID = 0
        BEGIN
            RAISERROR('StorageLocationTypeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @AreaLocationID IS NULL OR @AreaLocationID = 0
        BEGIN
            RAISERROR('AreaLocationID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @StorageLocationName IS NULL OR @StorageLocationName = ''
        BEGIN
            RAISERROR('StorageLocationName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @StorageLocationCode IS NULL OR @StorageLocationCode = ''
        BEGIN
            RAISERROR('StorageLocationCode is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @StorageLocationDescription IS NULL OR @StorageLocationDescription = ''
        BEGIN
            RAISERROR('StorageLocationDescription is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[StorageLocationTypes] WHERE [StorageLocationTypeID] = @StorageLocationTypeID)
        BEGIN
            RAISERROR('StorageLocationTypeID does not exist in StorageLocationTypes table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationID)
        BEGIN
            RAISERROR('AreaLocationID does not exist in AreaLocations table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[StorageLocations]
            ([StorageLocationTypeID], [AreaLocationID], [StorageLocationName], 
             [StorageLocationCode], [StorageLocationDescription], [StorageLocationActive])
        VALUES
            (@StorageLocationTypeID, @AreaLocationID, @StorageLocationName, 
             @StorageLocationCode, @StorageLocationDescription, @StorageLocationActive);
        
        -- Return the identity value
        SET @StorageLocationID = SCOPE_IDENTITY();
        
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