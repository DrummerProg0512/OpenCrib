
-- Update procedure for UsersAreas table
CREATE PROCEDURE [dbo].[usp_UsersAreas_Update]
    @UsersAreasID INT,
    @AreaLocationID INT = NULL,
    @UserID INT = NULL,
    @UpdatedOnString VARCHAR(27) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss.fff' (if provided, will override auto-update)
    @UpdatedBy INT = NULL,
    @UsersAreaActive BIT = NULL,
    @RowsAffected INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        DECLARE @UpdatedOn DATETIME2(7);
        
        -- Validate primary key
        IF @UsersAreasID IS NULL OR @UsersAreasID = 0
        BEGIN
            RAISERROR('UsersAreasID is required and must be greater than 0.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Verify record exists
        IF NOT EXISTS (SELECT 1 FROM [dbo].[UsersAreas] WHERE [UsersAreasID] = @UsersAreasID)
        BEGIN
            RAISERROR('UsersAreasID does not exist.', 16, 1);
            SET @RowsAffected = 0;
            RETURN 1;
        END;
        
        -- Validate provided foreign key references
        IF ISNULL(@AreaLocationID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationID)
            BEGIN
                RAISERROR('AreaLocationID does not exist in AreaLocations table.', 16, 1);
                SET @RowsAffected = 0;
                RETURN 1;
            END;
        END;
        
        IF ISNULL(@UserID, 0) > 0
        BEGIN
            IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID)
            BEGIN
                RAISERROR('UserID does not exist in Users table.', 16, 1);
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
        
        -- Convert UpdatedOn string if provided, otherwise use GETDATE()
        IF @UpdatedOnString IS NULL OR @UpdatedOnString = ''
        BEGIN
            SET @UpdatedOn = GETDATE();
        END
        ELSE
        BEGIN
            SET @UpdatedOn = CONVERT(DATETIME2(7), @UpdatedOnString);
        END;
        
        -- Update the record (only update provided fields)
        UPDATE [dbo].[UsersAreas]
        SET
            [AreaLocationID] = ISNULL(@AreaLocationID, [AreaLocationID]),
            [UserID] = ISNULL(@UserID, [UserID]),
            [UpdatedOn] = @UpdatedOn,
            [UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
            [UsersAreaActive] = ISNULL(@UsersAreaActive, [UsersAreaActive])
        WHERE
            [UsersAreasID] = @UsersAreasID;
        
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