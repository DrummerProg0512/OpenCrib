CREATE PROCEDURE [dbo].[usp_CurrencyCodes_Insert]
    @CountryName NVARCHAR(250),
    @CurrencyName NVARCHAR(150),
    @CurrencyCode NVARCHAR(20),
    @IsDefaultCurrency BIT,
    @UpdatedBy INT,
    @CurrencyCodeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @CurrencyName IS NULL OR @CurrencyName = ''
        BEGIN
            RAISERROR('CurrencyName is required.', 16, 1);
            RETURN 1;
        END;
        
        IF @CurrencyCode IS NULL OR @CurrencyCode = ''
        BEGIN
            RAISERROR('CurrencyCode is required.', 16, 1);
            RETURN 1;
        END;
        
        IF @IsDefaultCurrency IS NULL
        BEGIN
            RAISERROR('IsDefaultCurrency is required.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key reference for UpdatedBy
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL for CountryName
        SET @CountryName = NULLIF(@CountryName, '');
        
        -- Insert the record
        INSERT INTO [dbo].[CurrencyCodes]
            ([CountryName], [CurrencyName], [CurrencyCode], [IsDefaultCurrency], [UpdatedBy])
        VALUES
            (@CountryName, @CurrencyName, @CurrencyCode, @IsDefaultCurrency, @UpdatedBy);
        
        -- Return the identity value
        SET @CurrencyCodeID = SCOPE_IDENTITY();
        
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