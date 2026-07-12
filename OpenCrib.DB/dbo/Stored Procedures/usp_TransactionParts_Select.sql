
-- Select procedure for TransactionParts table
CREATE PROCEDURE [dbo].[usp_TransactionParts_Select]
    @TransactionPartID BIGINT = NULL,
    @TransactionID BIGINT = NULL,
    @PartID INT = NULL,
    @PartCostHistoryID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        SELECT
            tp.[TransactionPartID],
            tp.[TransactionID],
            th.[TransactionID] AS [TransactionIDRef],
            tp.[PartID],
            pi.[PartID] AS [PartIDRef],
            pi.[PartName],
            tp.[PartCostHistoryID],
            pch.[PartCostHistoryID] AS [PartCostHistoryIDRef],
            pch.CostAmount,
            tp.[UnitCost],
            tp.[Qty]
        FROM
            [dbo].[TransactionParts] tp
            INNER JOIN [dbo].[TransactionHistory] th ON tp.[TransactionID] = th.[TransactionID]
            INNER JOIN [dbo].[PartsItems] pi ON tp.[PartID] = pi.[PartID]
            INNER JOIN [dbo].[PartCostHistory] pch ON tp.[PartCostHistoryID] = pch.[PartCostHistoryID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@TransactionPartID, 0) > 0 AND tp.[TransactionPartID] = @TransactionPartID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@TransactionPartID, 0) = 0
                    AND (ISNULL(@TransactionID, 0) = 0 OR tp.[TransactionID] = @TransactionID)
                    AND (ISNULL(@PartID, 0) = 0 OR tp.[PartID] = @PartID)
                    AND (ISNULL(@PartCostHistoryID, 0) = 0 OR tp.[PartCostHistoryID] = @PartCostHistoryID)
                )
            )
        ORDER BY
            tp.[TransactionPartID];
        
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