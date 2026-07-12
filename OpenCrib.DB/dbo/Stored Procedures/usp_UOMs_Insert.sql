-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for UOMs table
CREATE PROCEDURE [dbo].[usp_UOMs_Insert]
    @UOM_Name NVARCHAR(150),
    @UOM_Code NVARCHAR(50),
    @UOM_Active BIT = 1,
    @UOM_ID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @UOM_Name IS NULL OR @UOM_Name = ''
        BEGIN
            RAISERROR('UOM_Name is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UOM_Code IS NULL OR @UOM_Code = ''
        BEGIN
            RAISERROR('UOM_Code is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[UOMs]
            ([UOM_Name], [UOM_Code], [UOM_Active])
        VALUES
            (@UOM_Name, @UOM_Code, ISNULL(@UOM_Active, 1));
        
        -- Return the identity value
        SET @UOM_ID = SCOPE_IDENTITY();
        
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