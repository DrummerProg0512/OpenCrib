
CREATE PROCEDURE [dbo].[usp_PartStorageLocations_Update]
    @PartStorageLocationID INT,
    @StorageLocationID INT = NULL,
    @PartID INT = NULL,
    @Qty DECIMAL(10, 2) = NULL,
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartStorageLocationID IS NULL OR @PartStorageLocationID = 0
        BEGIN
            RAISERROR('PartStorageLocationID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartStorageLocations] WHERE [PartStorageLocationID] = @PartStorageLocationID)
        BEGIN
            RAISERROR('PartStorageLocationID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF ISNULL(@StorageLocationID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[StorageLocations] WHERE [StorageLocationID] = @StorageLocationID)
            BEGIN
                RAISERROR('StorageLocationID does not exist in StorageLocations table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@PartID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
            BEGIN
                RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
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
        UPDATE [dbo].[PartStorageLocations]
        SET
            [StorageLocationID] = ISNULL(@StorageLocationID, [StorageLocationID]),
            [PartID] = ISNULL(@PartID, [PartID]),
            [Qty] = ISNULL(@Qty, [Qty]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [PartStorageLocationID] = @PartStorageLocationID;
        
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