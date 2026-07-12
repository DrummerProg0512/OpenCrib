
CREATE PROCEDURE [dbo].[usp_PartUsageTypes_Update]
    @PartUsageTypeID INT,
    @UsageTypeName NVARCHAR(250) = NULL,
    @UsageTypeActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @PartUsageTypeID IS NULL OR @PartUsageTypeID = 0
        BEGIN
            RAISERROR('PartUsageTypeID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[PartUsageTypes] WHERE [PartUsageTypeID] = @PartUsageTypeID)
        BEGIN
            RAISERROR('PartUsageTypeID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @UsageTypeName = ''
        BEGIN
            RAISERROR('UsageTypeName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[PartUsageTypes]
        SET
            [UsageTypeName] = ISNULL(@UsageTypeName, [UsageTypeName]),
            [UsageTypeActive] = ISNULL(@UsageTypeActive, [UsageTypeActive])
        WHERE
            [PartUsageTypeID] = @PartUsageTypeID;
        
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