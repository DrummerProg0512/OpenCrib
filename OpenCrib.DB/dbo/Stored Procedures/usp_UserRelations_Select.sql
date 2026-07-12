
-- Select procedure for UserRelations table
CREATE PROCEDURE [dbo].[usp_UserRelations_Select]
    @UserRelationID INT = NULL,
    @UserID_Parent INT = NULL,
    @UserID_Child INT = NULL,
    @UserRelationActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        SELECT
            ur.[UserRelationID],
            ur.[UserID_Parent],
            upParent.[UserID],
            upParent.[UserName] AS [ParentUserName],
            ur.[UserID_Child],
            upChild.[UserID],
            upChild.[UserName] AS [ChildUserName],
            ur.[UserRelationActive]
        FROM
            [dbo].[UserRelations] ur
            INNER JOIN [dbo].[Users] upParent ON ur.[UserID_Parent] = upParent.[UserID]
            INNER JOIN [dbo].[Users] upChild ON ur.[UserID_Child] = upChild.[UserID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@UserRelationID, 0) > 0 AND ur.[UserRelationID] = @UserRelationID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@UserRelationID, 0) = 0
                    AND (ISNULL(@UserID_Parent, 0) = 0 OR ur.[UserID_Parent] = @UserID_Parent)
                    AND (ISNULL(@UserID_Child, 0) = 0 OR ur.[UserID_Child] = @UserID_Child)
                    AND (@UserRelationActive IS NULL OR ur.[UserRelationActive] = @UserRelationActive)
                )
            )
        ORDER BY
            ur.[UserRelationID];
        
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