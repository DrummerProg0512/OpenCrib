
-- Update procedure for UOMs table
CREATE PROCEDURE [dbo].[usp_UOMs_Update]
    @UOM_ID INT,
    @UOM_Name NVARCHAR(150) = NULL,
    @UOM_Code NVARCHAR(50) = NULL,
    @UOM_Active BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @UOM_ID IS NULL OR @UOM_ID = 0
        BEGIN
            RAISERROR('UOM_ID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UOMs] WHERE [UOM_ID] = @UOM_ID)
        BEGIN
            RAISERROR('UOM_ID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @UOM_Name = NULLIF(@UOM_Name, '');
        SET @UOM_Code = NULLIF(@UOM_Code, '');
        
        -- Validate provided fields
        IF @UOM_Name IS NOT NULL AND @UOM_Name = ''
        BEGIN
            RAISERROR('UOM_Name cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @UOM_Code IS NOT NULL AND @UOM_Code = ''
        BEGIN
            RAISERROR('UOM_Code cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[UOMs]
        SET
            [UOM_Name] = ISNULL(@UOM_Name, [UOM_Name]),
            [UOM_Code] = ISNULL(@UOM_Code, [UOM_Code]),
            [UOM_Active] = ISNULL(@UOM_Active, [UOM_Active])
        WHERE
            [UOM_ID] = @UOM_ID;
        
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