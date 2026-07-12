
-- Update procedure for UserTypes table
CREATE PROCEDURE [dbo].[usp_UserTypes_Update]
    @UserTypeID INT,
    @UserTypeName NVARCHAR(255) = NULL,
    @CostApprovalLevel INT = NULL,
    @CostApprovalAmount DECIMAL(18, 0) = NULL,
    @IsActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @UserTypeID IS NULL OR @UserTypeID = 0
        BEGIN
            RAISERROR('UserTypeID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UserTypes] WHERE [UserTypeID] = @UserTypeID)
        BEGIN
            RAISERROR('UserTypeID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Normalize empty strings to NULL
        SET @UserTypeName = NULLIF(@UserTypeName, '');
        
        -- Validate provided fields
        IF @UserTypeName IS NOT NULL AND @UserTypeName = ''
        BEGIN
            RAISERROR('UserTypeName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[UserTypes]
        SET
            [UserTypeName] = ISNULL(@UserTypeName, [UserTypeName]),
            [CostApprovalLevel] = ISNULL(@CostApprovalLevel, [CostApprovalLevel]),
            [CostApprovalAmount] = ISNULL(@CostApprovalAmount, [CostApprovalAmount]),
            [IsActive] = ISNULL(@IsActive, [IsActive])
        WHERE
            [UserTypeID] = @UserTypeID;
        
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