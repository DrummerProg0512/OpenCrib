
CREATE PROCEDURE [dbo].[usp_StorageLocationTypes_Update]
    @StorageLocationTypeID INT,
    @StorageLocationTypeName NVARCHAR(150) = NULL,
    @StorageLocationTypeActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Validate primary key
        IF @StorageLocationTypeID IS NULL OR @StorageLocationTypeID = 0
        BEGIN
            RAISERROR('StorageLocationTypeID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[StorageLocationTypes] WHERE [StorageLocationTypeID] = @StorageLocationTypeID)
        BEGIN
            RAISERROR('StorageLocationTypeID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided fields
        IF @StorageLocationTypeName = ''
        BEGIN
            RAISERROR('StorageLocationTypeName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[StorageLocationTypes]
        SET
            [StorageLocationTypeName] = ISNULL(@StorageLocationTypeName, [StorageLocationTypeName]),
            [StorageLocationTypeActive] = ISNULL(@StorageLocationTypeActive, [StorageLocationTypeActive])
        WHERE
            [StorageLocationTypeID] = @StorageLocationTypeID;
        
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