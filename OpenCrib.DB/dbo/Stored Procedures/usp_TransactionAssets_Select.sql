
CREATE PROCEDURE [dbo].[usp_TransactionAssets_Select]
    @TransactionAssetID BIGINT = NULL,
    @TransactionID BIGINT = NULL,
    @AssetID BIGINT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        SELECT
            ta.[TransactionAssetID],
            ta.[TransactionID],
            th.[TransactionID] AS [TransactionIDRef],
            th.[RequestedBy],
            u.[UserID],
            u.[UserName],
            th.[RequestedOn],
            th.[TotalQty],
            th.[TotalCost],
            th.[TransactionTypeID],
            ts.[TransactionStatusID],
            ts.[TransactionStatusName],
            ta.[AssetID],
            pa.[AssetID] AS [AssetIDRef],
            pa.[SerialNumber],
            pa.[AssetTag],
            pa.[AssetStatusID],
            pa.[IsActive],
            pa.[UpdatedBy] AS [AssetUpdatedBy]
        FROM
            [dbo].[TransactionAssets] ta
            INNER JOIN [dbo].[TransactionHistory] th ON ta.[TransactionID] = th.[TransactionID]
            INNER JOIN [dbo].[Users] u ON th.[RequestedBy] = u.[UserID]
            INNER JOIN [dbo].[TransactionStatus] ts ON th.[TransactionTypeID] = ts.[TransactionStatusID]
            INNER JOIN [dbo].[PartAssets] pa ON ta.[AssetID] = pa.[AssetID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@TransactionAssetID, 0) > 0 AND ta.[TransactionAssetID] = @TransactionAssetID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@TransactionAssetID, 0) = 0
                    AND (ISNULL(@TransactionID, 0) = 0 OR ta.[TransactionID] = @TransactionID)
                    AND (ISNULL(@AssetID, 0) = 0 OR ta.[AssetID] = @AssetID)
                )
            )
        ORDER BY
            ta.[TransactionAssetID] DESC;
        
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