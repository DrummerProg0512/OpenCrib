-- Created by GitHub Copilot in SSMS - review carefully before executing

-- Insert procedure for UsersAreas table
CREATE PROCEDURE [dbo].[usp_UsersAreas_Insert]
    @AreaLocationID INT,
    @UserID INT,
    @UpdatedOnString VARCHAR(27) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss.fff' or NULL for GETDATE()
    @UpdatedBy INT,
    @UsersAreaActive BIT = 1,
    @UsersAreasID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        DECLARE @UpdatedOn DATETIME2(7);
        
        -- Validate required fields
        IF @AreaLocationID IS NULL OR @AreaLocationID = 0
        BEGIN
            RAISERROR('AreaLocationID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UserID IS NULL OR @UserID = 0
        BEGIN
            RAISERROR('UserID is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        IF @UpdatedBy IS NULL OR @UpdatedBy = 0
        BEGIN
            RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
            RETURN 1;
        END;
        
        -- Validate foreign key references
        IF NOT EXISTS (SELECT 1 FROM [dbo].[AreaLocations] WHERE [AreaLocationID] = @AreaLocationID)
        BEGIN
            RAISERROR('AreaLocationID does not exist in AreaLocations table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UserID)
        BEGIN
            RAISERROR('UserID does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
        BEGIN
            RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
            RETURN 1;
        END;
        
        -- Convert UpdatedOn string to DATETIME2 or use GETDATE()
        IF @UpdatedOnString IS NULL OR @UpdatedOnString = ''
        BEGIN
            SET @UpdatedOn = GETDATE();
        END
        ELSE
        BEGIN
            SET @UpdatedOn = CONVERT(DATETIME2(7), @UpdatedOnString);
        END;
        
        -- Insert the record
        INSERT INTO [dbo].[UsersAreas]
            ([AreaLocationID], [UserID], [UpdatedOn], [UpdatedBy], [UsersAreaActive])
        VALUES
            (@AreaLocationID, @UserID, @UpdatedOn, @UpdatedBy, ISNULL(@UsersAreaActive, 1));
        
        -- Return the identity value
        SET @UsersAreasID = SCOPE_IDENTITY();
        
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