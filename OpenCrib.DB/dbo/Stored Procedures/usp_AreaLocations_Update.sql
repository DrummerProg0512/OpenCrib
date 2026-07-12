CREATE PROCEDURE [dbo].[usp_AreaLocations_Update]
    @AreaLocationID INT,
    @AreaLocationTypeID INT = NULL,
    @AreaLocationName NVARCHAR(250) = NULL,
    @AreaLocationCode NVARCHAR(150) = NULL,
    @AreaLocationDescription NVARCHAR(500) = NULL,
    @AreaLocationActive BIT = NULL,
    @UpdatedBy INT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @AreaLocationName = NULLIF(LTRIM(RTRIM(@AreaLocationName)), '');
        SET @AreaLocationCode = NULLIF(LTRIM(RTRIM(@AreaLocationCode)), '');
        SET @AreaLocationDescription = NULLIF(LTRIM(RTRIM(@AreaLocationDescription)), '');
        
        -- Validate primary key
        IF @AreaLocationID IS NULL OR @AreaLocationID = 0
        BEGIN
            RAISERROR('AreaLocationID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationID)
        BEGIN
            RAISERROR('AreaLocationID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate required fields when provided
        IF @AreaLocationName IS NOT NULL AND @AreaLocationName = ''
        BEGIN
            RAISERROR('AreaLocationName cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        IF @AreaLocationCode IS NOT NULL AND @AreaLocationCode = ''
        BEGIN
            RAISERROR('AreaLocationCode cannot be empty.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate foreign key references when provided
        IF ISNULL(@AreaLocationTypeID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocationTypes] WHERE [AreaLocationTypeID] = @AreaLocationTypeID)
            BEGIN
                RAISERROR('AreaLocationTypeID does not exist in AreaLocationTypes table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UpdatedBy, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
            BEGIN
                RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[AreaLocations]
        SET
            [AreaLocationTypeID] = ISNULL(@AreaLocationTypeID, [AreaLocationTypeID]),
            [AreaLocationName] = ISNULL(@AreaLocationName, [AreaLocationName]),
            [AreaLocationCode] = ISNULL(@AreaLocationCode, [AreaLocationCode]),
            [AreaLocationDescription] = ISNULL(@AreaLocationDescription, [AreaLocationDescription]),
            [AreaLocationActive] = ISNULL(@AreaLocationActive, [AreaLocationActive]),
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UpdatedOn] = GETDATE()
        WHERE
            [AreaLocationID] = @AreaLocationID;
        
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