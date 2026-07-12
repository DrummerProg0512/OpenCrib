
CREATE PROCEDURE [dbo].[usp_PartsItems_Insert]
    @PartName NVARCHAR(250),
    @PartDescription NVARCHAR(2000),
    @VendorID INT,
    @PartItemCost DECIMAL(10, 2),
    @PartItemMin DECIMAL(10, 2),
    @PartItemMax DECIMAL(10, 2),
    @ShelfLife INT,
    @PartTypeCategoryID INT,
    @PartCode NVARCHAR(250),
    @PartActive BIT = 1,
    @UpdatedBy INT,
    @UOM_ID INT,
    @PartUsageTypeID INT,
    @PartTrackingTypeID INT,
    @PartID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @PartName IS NULL OR @PartName = ''
        BEGIN
            RAISERROR('PartName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartDescription IS NULL OR @PartDescription = ''
        BEGIN
            RAISERROR('PartDescription is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @VendorID IS NULL OR @VendorID = 0
        BEGIN
            RAISERROR('VendorID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartItemCost IS NULL OR @PartItemCost < 0
        BEGIN
            RAISERROR('PartItemCost is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartItemMin IS NULL OR @PartItemMin < 0
        BEGIN
            RAISERROR('PartItemMin is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartItemMax IS NULL OR @PartItemMax < 0
        BEGIN
            RAISERROR('PartItemMax is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @ShelfLife IS NULL OR @ShelfLife < 0
        BEGIN
            RAISERROR('ShelfLife is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartTypeCategoryID IS NULL OR @PartTypeCategoryID = 0
        BEGIN
            RAISERROR('PartTypeCategoryID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartCode IS NULL OR @PartCode = ''
        BEGIN
            RAISERROR('PartCode is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UOM_ID IS NULL OR @UOM_ID = 0
        BEGIN
            RAISERROR('UOM_ID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartUsageTypeID IS NULL OR @PartUsageTypeID = 0
        BEGIN
            RAISERROR('PartUsageTypeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @PartTrackingTypeID IS NULL OR @PartTrackingTypeID = 0
        BEGIN
            RAISERROR('PartTrackingTypeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[ProvidersVendorsCompanies] WHERE [VendorID] = @VendorID)
        BEGIN
            RAISERROR('VendorID does not exist in ProvidersVendorsCompanies table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartTypeCategory] WHERE [PartTypeCategoryID] = @PartTypeCategoryID)
        BEGIN
            RAISERROR('PartTypeCategoryID does not exist in PartTypeCategory table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UOMs] WHERE [UOM_ID] = @UOM_ID)
        BEGIN
            RAISERROR('UOM_ID does not exist in UOMs table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartUsageTypes] WHERE [PartUsageTypeID] = @PartUsageTypeID)
        BEGIN
            RAISERROR('PartUsageTypeID does not exist in PartUsageTypes table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartTrackingTypes] WHERE [PartTrackingTypeID] = @PartTrackingTypeID)
        BEGIN
            RAISERROR('PartTrackingTypeID does not exist in PartTrackingTypes table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[PartsItems]
            ([PartName], [PartDescription], [VendorID], [PartItemCost], [PartItemMin], 
             [PartItemMax], [ShelfLife], [PartTypeCategoryID], [PartCode], [PartActive], 
             [UpdatedBy], [UOM_ID], [PartUsageTypeID], [PartTrackingTypeID])
        VALUES
            (@PartName, @PartDescription, @VendorID, @PartItemCost, @PartItemMin, 
             @PartItemMax, @ShelfLife, @PartTypeCategoryID, @PartCode, @PartActive, 
             @UpdatedBy, @UOM_ID, @PartUsageTypeID, @PartTrackingTypeID);
        
        -- Return the identity value
        SET @PartID = SCOPE_IDENTITY();
        
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