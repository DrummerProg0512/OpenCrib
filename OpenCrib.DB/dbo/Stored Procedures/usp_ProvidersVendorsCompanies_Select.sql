
CREATE PROCEDURE [dbo].[usp_ProvidersVendorsCompanies_Select]
    @VendorID INT = NULL,
    @VendorName NVARCHAR(250) = NULL,
    @VendorShortName NVARCHAR(150) = NULL,
    @CompanyActive BIT = NULL,
    @UpdatedBy INT = NULL,
    @UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @VendorName = NULLIF(@VendorName, '');
        SET @VendorShortName = NULLIF(@VendorShortName, '');
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            pvc.[VendorID],
            pvc.[VendorName],
            pvc.[VendorShortName],
            pvc.[VendorURL],
            pvc.[VendorAddress],
            pvc.[CompanyActive],
            pvc.[Phone1],
            pvc.[Phone2],
            pvc.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            pvc.[UpdatedOn]
        FROM
            [dbo].[ProvidersVendorsCompanies] pvc
            INNER JOIN [dbo].[Users] u ON pvc.[UpdatedBy] = u.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@VendorID, 0) > 0 AND pvc.[VendorID] = @VendorID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@VendorID, 0) = 0
                    AND (@VendorName IS NULL OR pvc.[VendorName] LIKE '%' + @VendorName + '%')
                    AND (@VendorShortName IS NULL OR pvc.[VendorShortName] LIKE '%' + @VendorShortName + '%')
                    AND (@CompanyActive IS NULL OR pvc.[CompanyActive] = @CompanyActive)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR pvc.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR pvc.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR pvc.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            pvc.[VendorID] DESC;
        
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