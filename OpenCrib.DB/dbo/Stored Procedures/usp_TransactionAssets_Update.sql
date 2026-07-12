
CREATE PROCEDURE [dbo].[usp_TransactionAssets_Update]
    @TransactionAssetID BIGINT,
    @TransactionID BIGINT = NULL,
    @AssetID BIGINT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @TransactionAssetID IS NULL OR @TransactionAssetID = 0
        BEGIN
            RAISERROR('TransactionAssetID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionAssets] WHERE [TransactionAssetID] = @TransactionAssetID)
        BEGIN
            RAISERROR('TransactionAssetID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF ISNULL(@TransactionID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
            BEGIN
                RAISERROR('TransactionID does not exist in TransactionHistory table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@AssetID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[PartAssets] WHERE [AssetID] = @AssetID)
            BEGIN
                RAISERROR('AssetID does not exist in PartAssets table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[TransactionAssets]
        SET
            [TransactionID] = ISNULL(@TransactionID, [TransactionID]),
            [AssetID] = ISNULL(@AssetID, [AssetID])
        WHERE
            [TransactionAssetID] = @TransactionAssetID;
        
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