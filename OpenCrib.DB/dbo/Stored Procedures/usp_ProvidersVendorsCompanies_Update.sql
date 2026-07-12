
CREATE PROCEDURE [dbo].[usp_ProvidersVendorsCompanies_Update]
    @VendorID INT,
    @VendorName NVARCHAR(250) = NULL,
    @VendorShortName NVARCHAR(150) = NULL,
    @VendorURL NVARCHAR(500) = NULL,
    @VendorAddress NVARCHAR(2000) = NULL,
    @CompanyActive BIT = NULL,
    @Phone1 NVARCHAR(150) = NULL,
    @Phone2 NVARCHAR(150) = NULL,
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @VendorID IS NULL OR @VendorID = 0
        BEGIN
            RAISERROR('VendorID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[ProvidersVendorsCompanies] WHERE [VendorID] = @VendorID)
        BEGIN
            RAISERROR('VendorID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @VendorName = ''
        BEGIN
            RAISERROR('VendorName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @VendorShortName = ''
        BEGIN
            RAISERROR('VendorShortName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @VendorURL = ''
        BEGIN
            RAISERROR('VendorURL cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @VendorAddress = ''
        BEGIN
            RAISERROR('VendorAddress cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @Phone1 = ''
        BEGIN
            RAISERROR('Phone1 cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @Phone2 = ''
        BEGIN
            RAISERROR('Phone2 cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
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
        UPDATE [dbo].[ProvidersVendorsCompanies]
        SET
            [VendorName] = ISNULL(@VendorName, [VendorName]),
            [VendorShortName] = ISNULL(@VendorShortName, [VendorShortName]),
            [VendorURL] = ISNULL(@VendorURL, [VendorURL]),
            [VendorAddress] = ISNULL(@VendorAddress, [VendorAddress]),
            [CompanyActive] = ISNULL(@CompanyActive, [CompanyActive]),
            [Phone1] = ISNULL(@Phone1, [Phone1]),
            [Phone2] = ISNULL(@Phone2, [Phone2]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [VendorID] = @VendorID;
        
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