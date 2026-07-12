
CREATE PROCEDURE [dbo].[usp_ProvidersVendorsCompanies_Insert]
    @VendorName NVARCHAR(250),
    @VendorShortName NVARCHAR(150),
    @VendorURL NVARCHAR(500),
    @VendorAddress NVARCHAR(2000),
    @CompanyActive BIT = 1,
    @Phone1 NVARCHAR(150),
    @Phone2 NVARCHAR(150),
    @UpdatedBy INT,
    @VendorID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @VendorName IS NULL OR @VendorName = ''
        BEGIN
            RAISERROR('VendorName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @VendorShortName IS NULL OR @VendorShortName = ''
        BEGIN
            RAISERROR('VendorShortName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @VendorURL IS NULL OR @VendorURL = ''
        BEGIN
            RAISERROR('VendorURL is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @VendorAddress IS NULL OR @VendorAddress = ''
        BEGIN
            RAISERROR('VendorAddress is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @Phone1 IS NULL OR @Phone1 = ''
        BEGIN
            RAISERROR('Phone1 is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @Phone2 IS NULL OR @Phone2 = ''
        BEGIN
            RAISERROR('Phone2 is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[ProvidersVendorsCompanies]
            ([VendorName], [VendorShortName], [VendorURL], [VendorAddress], 
             [CompanyActive], [Phone1], [Phone2], [UpdatedBy])
        VALUES
            (@VendorName, @VendorShortName, @VendorURL, @VendorAddress, 
             @CompanyActive, @Phone1, @Phone2, @UpdatedBy);
        
        -- Return the identity value
        SET @VendorID = SCOPE_IDENTITY();
        
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