CREATE PROCEDURE [dbo].[usp_CurrencyCodes_Update]
    @CurrencyCodeID INT,
    @CountryName NVARCHAR(250) = NULL,
    @CurrencyName NVARCHAR(150) = NULL,
    @CurrencyCode NVARCHAR(20) = NULL,
    @IsDefaultCurrency BIT = NULL,
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @CurrencyCodeID IS NULL OR @CurrencyCodeID = 0
        BEGIN
            RAISERROR('CurrencyCodeID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[CurrencyCodes] WHERE [CurrencyCodeID] = @CurrencyCodeID)
        BEGIN
            RAISERROR('CurrencyCodeID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @CurrencyName IS NOT NULL AND @CurrencyName = ''
        BEGIN
            RAISERROR('CurrencyName cannot be an empty string.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @CurrencyCode IS NOT NULL AND @CurrencyCode = ''
        BEGIN
            RAISERROR('CurrencyCode cannot be an empty string.', 16, 1);
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
        
        -- Normalize empty strings to NULL for CountryName
        SET @CountryName = NULLIF(@CountryName, '');
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[CurrencyCodes]
        SET
            [CountryName] = ISNULL(@CountryName, [CountryName]),
            [CurrencyName] = ISNULL(@CurrencyName, [CurrencyName]),
            [CurrencyCode] = ISNULL(@CurrencyCode, [CurrencyCode]),
            [IsDefaultCurrency] = ISNULL(@IsDefaultCurrency, [IsDefaultCurrency]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [CurrencyCodeID] = @CurrencyCodeID;
        
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