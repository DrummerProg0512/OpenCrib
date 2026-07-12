
CREATE PROCEDURE [dbo].[usp_PartStorageLocations_Insert]
    @StorageLocationID INT,
    @PartID INT,
    @Qty DECIMAL(10, 2),
    @UpdatedBy INT,
    @PartStorageLocationID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @StorageLocationID IS NULL OR @StorageLocationID = 0
        BEGIN
            RAISERROR('StorageLocationID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartID IS NULL OR @PartID = 0
        BEGIN
            RAISERROR('PartID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @Qty IS NULL OR @Qty < 0
        BEGIN
            RAISERROR('Qty is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[StorageLocations] WHERE [StorageLocationID] = @StorageLocationID)
        BEGIN
            RAISERROR('StorageLocationID does not exist in StorageLocations table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
        BEGIN
            RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[PartStorageLocations]
            ([StorageLocationID], [PartID], [Qty], [UpdatedBy])
        VALUES
            (@StorageLocationID, @PartID, @Qty, @UpdatedBy);
        
        -- Return the identity value
        SET @PartStorageLocationID = SCOPE_IDENTITY();
        
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