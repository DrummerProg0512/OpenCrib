
-- Select procedure for UserTypes table
CREATE PROCEDURE [dbo].[usp_UserTypes_Select]
    @UserTypeID INT = NULL,
    @UserTypeName NVARCHAR(255) = NULL,
    @CostApprovalLevel INT = NULL,
    @IsActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @UserTypeName = NULLIF(@UserTypeName, '');
        
        SELECT
            ut.[UserTypeID],
            ut.[UserTypeName],
            ut.[CostApprovalLevel],
            ut.[CostApprovalAmount],
            ut.[IsActive]
        FROM
            [dbo].[UserTypes] ut
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@UserTypeID, 0) > 0 AND ut.[UserTypeID] = @UserTypeID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@UserTypeID, 0) = 0
                    AND (@UserTypeName IS NULL OR ut.[UserTypeName] = @UserTypeName)
                    AND (ISNULL(@CostApprovalLevel, 0) = 0 OR ut.[CostApprovalLevel] = @CostApprovalLevel)
                    AND (@IsActive IS NULL OR ut.[IsActive] = @IsActive)
                )
            )
        ORDER BY
            ut.[UserTypeID];
        
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