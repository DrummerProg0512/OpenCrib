
CREATE PROCEDURE [dbo].[usp_PartTypeCategory_Select]
    @PartTypeCategoryID INT = NULL,
    @PartTypeName NVARCHAR(150) = NULL,
    @PartTypeActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @PartTypeName = NULLIF(@PartTypeName, '');
        
        SELECT
            ptc.[PartTypeCategoryID],
            ptc.[PartTypeName],
            ptc.[PartTypeActive],
            ptc.[PartTypeDescription]
        FROM
            [dbo].[PartTypeCategory] ptc
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartTypeCategoryID, 0) > 0 AND ptc.[PartTypeCategoryID] = @PartTypeCategoryID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartTypeCategoryID, 0) = 0
                    AND (@PartTypeName IS NULL OR ptc.[PartTypeName] LIKE '%' + @PartTypeName + '%')
                    AND (@PartTypeActive IS NULL OR ptc.[PartTypeActive] = @PartTypeActive)
                )
            )
        ORDER BY
            ptc.[PartTypeCategoryID] DESC;
        
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