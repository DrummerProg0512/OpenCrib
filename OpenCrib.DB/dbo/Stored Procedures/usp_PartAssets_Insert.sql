
CREATE PROCEDURE [dbo].[usp_PartAssets_Insert]
	@PartID INT,
	@SerialNumber NVARCHAR(100),
	@AssetTag NVARCHAR(1024),
	@AssetStatusID INT,
	@PurchaseDate VARCHAR(10) = NULL,
	@WarrantyExpiration VARCHAR(10) = NULL,
	@LastCalibrationDate VARCHAR(10) = NULL,
	@NextCalibrationDate VARCHAR(10) = NULL,
	@AssetCondition INT,
	@IsActive BIT = 1,
	@UpdatedBy INT,
	@AssetID BIGINT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF @PartID IS NULL OR @PartID = 0
		BEGIN
			RAISERROR('PartID is required and must be greater than 0.', 16, 1);
			RETURN 1;
		END;

		IF @SerialNumber IS NULL OR @SerialNumber = ''
		BEGIN
			RAISERROR('SerialNumber is required and cannot be empty.', 16, 1);
			RETURN 1;
		END;

		IF @AssetTag IS NULL OR @AssetTag = ''
		BEGIN
			RAISERROR('AssetTag is required and cannot be empty.', 16, 1);
			RETURN 1;
		END;

		IF @AssetStatusID IS NULL OR @AssetStatusID = 0
		BEGIN
			RAISERROR('AssetStatusID is required and must be greater than 0.', 16, 1);
			RETURN 1;
		END;

		IF @AssetCondition IS NULL OR @AssetCondition = 0
		BEGIN
			RAISERROR('AssetCondition is required and must be greater than 0.', 16, 1);
			RETURN 1;
		END;

		IF @UpdatedBy IS NULL OR @UpdatedBy = 0
		BEGIN
			RAISERROR('UpdatedBy is required and must be greater than 0.', 16, 1);
			RETURN 1;
		END;

		IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
		BEGIN
			RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
			RETURN 1;
		END;

		IF NOT EXISTS (SELECT 1 FROM [dbo].[PartAssets] WHERE [AssetStatusID] = @AssetStatusID)
		BEGIN
			RAISERROR('AssetStatusID does not exist in AssetStatus table.', 16, 1);
			RETURN 1;
		END;

		IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [UserID] = @UpdatedBy)
		BEGIN
			RAISERROR('UpdatedBy does not exist in Users table.', 16, 1);
			RETURN 1;
		END;

		SET @PurchaseDate = NULLIF(@PurchaseDate, '');
		SET @WarrantyExpiration = NULLIF(@WarrantyExpiration, '');
		SET @LastCalibrationDate = NULLIF(@LastCalibrationDate, '');
		SET @NextCalibrationDate = NULLIF(@NextCalibrationDate, '');

		INSERT INTO [dbo].[PartAssets]
			([PartID], [SerialNumber], [AssetTag], [AssetStatusID], [PurchaseDate], 
			 [WarrantyExpiration], [LastCalibrationDate], [NextCalibrationDate], 
			 AssetCondiftion, [IsActive], [UpdatedBy])
		VALUES
			(@PartID, @SerialNumber, @AssetTag, @AssetStatusID, 
			 CONVERT(DATE, @PurchaseDate),
			 CONVERT(DATE, @WarrantyExpiration),
			 CONVERT(DATE, @LastCalibrationDate),
			 CONVERT(DATE, @NextCalibrationDate),
			 @AssetCondition, @IsActive, @UpdatedBy);

		SET @AssetID = SCOPE_IDENTITY();

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