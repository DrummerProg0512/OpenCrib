-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for UserTypes table
CREATE PROCEDURE [dbo].[usp_UserTypes_Insert]
    @UserTypeName NVARCHAR(255),
    @CostApprovalLevel INT,
    @CostApprovalAmount DECIMAL(18, 0),
    @IsActive BIT = 1,
    @UserTypeID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @UserTypeName IS NULL OR @UserTypeName = ''
        BEGIN
            RAISERROR('UserTypeName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @CostApprovalLevel IS NULL
        BEGIN
            RAISERROR('CostApprovalLevel is required.', 16, 1);
            RETURN 1;
        END;
        
        IF @CostApprovalAmount IS NULL
        BEGIN
            RAISERROR('CostApprovalAmount is required.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[UserTypes]
            ([UserTypeName], [CostApprovalLevel], [CostApprovalAmount], [IsActive])
        VALUES
            (@UserTypeName, @CostApprovalLevel, @CostApprovalAmount, ISNULL(@IsActive, 1));
        
        -- Return the identity value
        SET @UserTypeID = SCOPE_IDENTITY();
        
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