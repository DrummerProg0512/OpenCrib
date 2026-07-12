
CREATE PROCEDURE [dbo].[usp_TransactionAssets_Insert]
    @TransactionID BIGINT,
    @AssetID BIGINT,
    @TransactionAssetID BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @TransactionID IS NULL OR @TransactionID = 0
        BEGIN
            RAISERROR('TransactionID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @AssetID IS NULL OR @AssetID = 0
        BEGIN
            RAISERROR('AssetID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionHistory] WHERE [TransactionID] = @TransactionID)
        BEGIN
            RAISERROR('TransactionID does not exist in TransactionHistory table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartAssets] WHERE [AssetID] = @AssetID)
        BEGIN
            RAISERROR('AssetID does not exist in PartAssets table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[TransactionAssets]
            ([TransactionID], [AssetID])
        VALUES
            (@TransactionID, @AssetID);
        
        -- Return the identity value
        SET @TransactionAssetID = SCOPE_IDENTITY();
        
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