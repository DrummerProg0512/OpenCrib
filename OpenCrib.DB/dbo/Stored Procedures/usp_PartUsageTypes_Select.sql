
CREATE PROCEDURE [dbo].[usp_PartUsageTypes_Select]
    @PartUsageTypeID INT = NULL,
    @UsageTypeName NVARCHAR(250) = NULL,
    @UsageTypeActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UsageTypeName = NULLIF(@UsageTypeName, '');
        
        SELECT
            put.[PartUsageTypeID],
            put.[UsageTypeName],
            put.[UsageTypeActive]
        FROM
            [dbo].[PartUsageTypes] put
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartUsageTypeID, 0) > 0 AND put.[PartUsageTypeID] = @PartUsageTypeID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartUsageTypeID, 0) = 0
                    AND (@UsageTypeName IS NULL OR put.[UsageTypeName] LIKE '%' + @UsageTypeName + '%')
                    AND (@UsageTypeActive IS NULL OR put.[UsageTypeActive] = @UsageTypeActive)
                )
            )
        ORDER BY
            put.[PartUsageTypeID] DESC;
        
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