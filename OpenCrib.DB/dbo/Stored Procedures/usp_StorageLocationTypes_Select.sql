
CREATE PROCEDURE [dbo].[usp_StorageLocationTypes_Select]
    @StorageLocationTypeID INT = NULL,
    @StorageLocationTypeName NVARCHAR(150) = NULL,
    @StorageLocationTypeActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @StorageLocationTypeName = NULLIF(@StorageLocationTypeName, '');
        
        SELECT
            slt.[StorageLocationTypeID],
            slt.[StorageLocationTypeName],
            slt.[StorageLocationTypeActive]
        FROM
            [dbo].[StorageLocationTypes] slt
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@StorageLocationTypeID, 0) > 0 AND slt.[StorageLocationTypeID] = @StorageLocationTypeID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@StorageLocationTypeID, 0) = 0
                    AND (@StorageLocationTypeName IS NULL OR slt.[StorageLocationTypeName] LIKE '%' + @StorageLocationTypeName + '%')
                    AND (@StorageLocationTypeActive IS NULL OR slt.[StorageLocationTypeActive] = @StorageLocationTypeActive)
                )
            )
        ORDER BY
            slt.[StorageLocationTypeID] DESC;
        
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