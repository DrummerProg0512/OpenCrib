
CREATE PROCEDURE [dbo].[usp_TransactionHistory_Insert]
    @RequestedBy INT,
    @TotalQty INT,
    @TotalCost DECIMAL(12, 2),
    @TransactionTypeID INT,
    @TransactionID BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate required fields
        IF @RequestedBy IS NULL OR @RequestedBy = 0
        BEGIN
            RAISERROR('RequestedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @TotalQty IS NULL OR @TotalQty < 0
        BEGIN
            RAISERROR('TotalQty is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @TotalCost IS NULL OR @TotalCost < 0
        BEGIN
            RAISERROR('TotalCost is required and must be greater than or equal to 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @TransactionTypeID IS NULL OR @TransactionTypeID = 0
        BEGIN
            RAISERROR('TransactionTypeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @RequestedBy)
        BEGIN
            RAISERROR('RequestedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionStatus] WHERE [TransactionStatusID] = @TransactionTypeID)
        BEGIN
            RAISERROR('TransactionTypeID does not exist in TransactionStatus table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[TransactionHistory]
            ([RequestedBy], [TotalQty], [TotalCost], [TransactionTypeID])
        VALUES
            (@RequestedBy, @TotalQty, @TotalCost, @TransactionTypeID);
        
        -- Return the identity value
        SET @TransactionID = SCOPE_IDENTITY();
        
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