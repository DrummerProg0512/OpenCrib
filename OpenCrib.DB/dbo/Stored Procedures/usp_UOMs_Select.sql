
-- Select procedure for UOMs table
CREATE PROCEDURE [dbo].[usp_UOMs_Select]
    @UOM_ID INT = NULL,
    @UOM_Name NVARCHAR(150) = NULL,
    @UOM_Code NVARCHAR(50) = NULL,
    @UOM_Active BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UOM_Name = NULLIF(@UOM_Name, '');
        SET @UOM_Code = NULLIF(@UOM_Code, '');
        
        SELECT
            u.[UOM_ID],
            u.[UOM_Name],
            u.[UOM_Code],
            u.[UOM_Active]
        FROM
            [dbo].[UOMs] u
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@UOM_ID, 0) > 0 AND u.[UOM_ID] = @UOM_ID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@UOM_ID, 0) = 0
                    AND (@UOM_Name IS NULL OR u.[UOM_Name] = @UOM_Name)
                    AND (@UOM_Code IS NULL OR u.[UOM_Code] = @UOM_Code)
                    AND (@UOM_Active IS NULL OR u.[UOM_Active] = @UOM_Active)
                )
            )
        ORDER BY
            u.[UOM_ID];
        
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