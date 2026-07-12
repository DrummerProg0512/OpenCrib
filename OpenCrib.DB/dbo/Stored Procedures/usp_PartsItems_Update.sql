
CREATE PROCEDURE [dbo].[usp_PartsItems_Update]
    @PartID INT,
    @PartName NVARCHAR(250) = NULL,
    @PartDescription NVARCHAR(2000) = NULL,
    @VendorID INT = NULL,
    @PartItemCost DECIMAL(10, 2) = NULL,
    @PartItemMin DECIMAL(10, 2) = NULL,
    @PartItemMax DECIMAL(10, 2) = NULL,
    @ShelfLife INT = NULL,
    @PartTypeCategoryID INT = NULL,
    @PartCode NVARCHAR(250) = NULL,
    @PartActive BIT = NULL,
    @UpdatedBy INT = NULL,
    @UOM_ID INT = NULL,
    @PartUsageTypeID INT = NULL,
    @PartTrackingTypeID INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartID IS NULL OR @PartID = 0
        BEGIN
            RAISERROR('PartID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
        BEGIN
            RAISERROR('PartID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @PartName = ''
        BEGIN
            RAISERROR('PartName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @PartDescription = ''
        BEGIN
            RAISERROR('PartDescription cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @PartCode = ''
        BEGIN
            RAISERROR('PartCode cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF ISNULL(@VendorID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[ProvidersVendorsCompanies] WHERE [VendorID] = @VendorID)
            BEGIN
                RAISERROR('VendorID does not exist in ProvidersVendorsCompanies table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@PartTypeCategoryID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartTypeCategory] WHERE [PartTypeCategoryID] = @PartTypeCategoryID)
            BEGIN
                RAISERROR('PartTypeCategoryID does not exist in PartTypeCategory table.', 16, 1);
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
        
        IF ISNULL(@UOM_ID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[UOMs] WHERE [UOM_ID] = @UOM_ID)
            BEGIN
                RAISERROR('UOM_ID does not exist in UOMs table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@PartUsageTypeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartUsageTypes] WHERE [PartUsageTypeID] = @PartUsageTypeID)
            BEGIN
                RAISERROR('PartUsageTypeID does not exist in PartUsageTypes table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@PartTrackingTypeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartTrackingTypes] WHERE [PartTrackingTypeID] = @PartTrackingTypeID)
            BEGIN
                RAISERROR('PartTrackingTypeID does not exist in PartTrackingTypes table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[PartsItems]
        SET
            [PartName] = ISNULL(@PartName, [PartName]),
            [PartDescription] = ISNULL(@PartDescription, [PartDescription]),
            [VendorID] = ISNULL(@VendorID, [VendorID]),
            [PartItemCost] = ISNULL(@PartItemCost, [PartItemCost]),
            [PartItemMin] = ISNULL(@PartItemMin, [PartItemMin]),
            [PartItemMax] = ISNULL(@PartItemMax, [PartItemMax]),
            [ShelfLife] = ISNULL(@ShelfLife, [ShelfLife]),
            [PartTypeCategoryID] = ISNULL(@PartTypeCategoryID, [PartTypeCategoryID]),
            [PartCode] = ISNULL(@PartCode, [PartCode]),
            [PartActive] = ISNULL(@PartActive, [PartActive]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UOM_ID] = ISNULL(@UOM_ID, [UOM_ID]),
            [PartUsageTypeID] = ISNULL(@PartUsageTypeID, [PartUsageTypeID]),
            [PartTrackingTypeID] = ISNULL(@PartTrackingTypeID, [PartTrackingTypeID]),
            [UpdatedOn] = GETDATE()
        WHERE
            [PartID] = @PartID;
        
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