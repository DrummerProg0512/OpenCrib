CREATE PROCEDURE [dbo].[usp_AreaLocationTypes_Update]
    @AreaLocationTypeID INT,
    @AreaLocationTypeName NVARCHAR(150) = NULL,
    @AreaLocationTypeActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @AreaLocationTypeName = NULLIF(LTRIM(RTRIM(@AreaLocationTypeName)), '');
        
        -- Validate primary key
        IF @AreaLocationTypeID IS NULL OR @AreaLocationTypeID = 0
        BEGIN
            RAISERROR('AreaLocationTypeID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocationTypes] WHERE [AreaLocationTypeID] = @AreaLocationTypeID)
        BEGIN
            RAISERROR('AreaLocationTypeID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate required fields when provided
        IF @AreaLocationTypeName IS NOT NULL AND @AreaLocationTypeName = ''
        BEGIN
            RAISERROR('AreaLocationTypeName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[AreaLocationTypes]
        SET
            [AreaLocationTypeName] = ISNULL(@AreaLocationTypeName, [AreaLocationTypeName]),
            [AreaLocationTypeActive] = ISNULL(@AreaLocationTypeActive, [AreaLocationTypeActive])
        WHERE
            [AreaLocationTypeID] = @AreaLocationTypeID;
        
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