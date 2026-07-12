CREATE PROCEDURE [dbo].[usp_AreaLocations_Insert]
    @AreaLocationTypeID INT,
    @AreaLocationName NVARCHAR(250),
    @AreaLocationCode NVARCHAR(150),
    @AreaLocationDescription NVARCHAR(500),
    @AreaLocationActive BIT = 1,
    @UpdatedBy INT,
    @AreaLocationID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @AreaLocationName = NULLIF(LTRIM(RTRIM(@AreaLocationName)), '');
        SET @AreaLocationCode = NULLIF(LTRIM(RTRIM(@AreaLocationCode)), '');
        SET @AreaLocationDescription = NULLIF(LTRIM(RTRIM(@AreaLocationDescription)), '');
        
        -- Validate required fields
        IF @AreaLocationTypeID IS NULL OR @AreaLocationTypeID = 0
        BEGIN
            RAISERROR('AreaLocationTypeID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @AreaLocationName IS NULL
        BEGIN
            RAISERROR('AreaLocationName is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @AreaLocationCode IS NULL
        BEGIN
            RAISERROR('AreaLocationCode is required and cannot be empty.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocationTypes] WHERE [AreaLocationTypeID] = @AreaLocationTypeID)
        BEGIN
            RAISERROR('AreaLocationTypeID does not exist in AreaLocationTypes table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[AreaLocations]
            ([AreaLocationTypeID], [AreaLocationName], [AreaLocationCode], [AreaLocationDescription], [AreaLocationActive], [UpdatedBy])
        VALUES
            (@AreaLocationTypeID, @AreaLocationName, @AreaLocationCode, ISNULL(@AreaLocationDescription, ''), @AreaLocationActive, @UpdatedBy);
        
        -- Return the identity value
        SET @AreaLocationID = SCOPE_IDENTITY();
        
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