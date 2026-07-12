
CREATE PROCEDURE [dbo].[usp_PartAssets_Update]
	@AssetID BIGINT,
	@PartID INT = NULL,
	@SerialNumber NVARCHAR(100) = NULL,
	@AssetTag NVARCHAR(1024) = NULL,
	@AssetStatusID INT = NULL,
	@PurchaseDate VARCHAR(10) = NULL,  -- Format: 'YYYY-MM-DD'
	@WarrantyExpiration VARCHAR(10) = NULL,  -- Format: 'YYYY-MM-DD'
	@LastCalibrationDate VARCHAR(10) = NULL,  -- Format: 'YYYY-MM-DD'
	@NextCalibrationDate VARCHAR(10) = NULL,  -- Format: 'YYYY-MM-DD'
	@AssetCondiftion INT = NULL,
	@IsActive BIT = NULL,
	@UpdatedBy INT = NULL,
	@RowsAffected INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- Validate primary key
		IF @AssetID IS NULL OR @AssetID = 0
		BEGIN
			RAISERROR('AssetID is required and must be greater than 0.', 16, 1);
			SET @RowsAffected = 0;
			RETURN 1;
		END;

		-- Verify record exists
		IF NOT EXISTS (SELECT 1 FROM [dbo].[PartAssets] WHERE [AssetID] = @AssetID)
		BEGIN
			RAISERROR('AssetID does not exist.', 16, 1);
			SET @RowsAffected = 0;
			RETURN 1;
		END;

		-- Validate provided fields
		IF ISNULL(@PartID, 0) > 0
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM [dbo].[PartsItems] WHERE [PartID] = @PartID)
			BEGIN
				RAISERROR('PartID does not exist in PartsItems table.', 16, 1);
				SET @RowsAffected = 0;
				RETURN 1;
			END;
		END;

		IF ISNULL(@AssetStatusID, 0) > 0
		BEGIN
			IF NOT EXISTS (SELECT 1 FROM [dbo].PartAssets WHERE [AssetStatusID] = @AssetStatusID)
			BEGIN
				RAISERROR('AssetStatusID does not exist in AssetStatus table.', 16, 1);
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

		-- Validate string fields are not empty when provided
		IF @SerialNumber = ''
		BEGIN
			RAISERROR('SerialNumber cannot be empty.', 16, 1);
			SET @RowsAffected = 0;
			RETURN 1;
		END;

		IF @AssetTag = ''
		BEGIN
			RAISERROR('AssetTag cannot be empty.', 16, 1);
			SET @RowsAffected = 0;
			RETURN 1;
		END;

		-- Normalize empty strings to NULL for date parameters
		SET @PurchaseDate = NULLIF(@PurchaseDate, '');
		SET @WarrantyExpiration = NULLIF(@WarrantyExpiration, '');
		SET @LastCalibrationDate = NULLIF(@LastCalibrationDate, '');
		SET @NextCalibrationDate = NULLIF(@NextCalibrationDate, '');

		-- Update the record (only update provided fields)
		UPDATE [dbo].[PartAssets]
		SET
			[PartID] = ISNULL(@PartID, [PartID]),
			[SerialNumber] = ISNULL(@SerialNumber, [SerialNumber]),
			[AssetTag] = ISNULL(@AssetTag, [AssetTag]),
			[AssetStatusID] = ISNULL(@AssetStatusID, [AssetStatusID]),
			[PurchaseDate] = CASE WHEN @PurchaseDate IS NOT NULL THEN CONVERT(DATE, @PurchaseDate) ELSE [PurchaseDate] END,
			[WarrantyExpiration] = CASE WHEN @WarrantyExpiration IS NOT NULL THEN CONVERT(DATE, @WarrantyExpiration) ELSE [WarrantyExpiration] END,
			[LastCalibrationDate] = CASE WHEN @LastCalibrationDate IS NOT NULL THEN CONVERT(DATE, @LastCalibrationDate) ELSE [LastCalibrationDate] END,
			[NextCalibrationDate] = CASE WHEN @NextCalibrationDate IS NOT NULL THEN CONVERT(DATE, @NextCalibrationDate) ELSE [NextCalibrationDate] END,
			[AssetCondiftion] = ISNULL(@AssetCondiftion, [AssetCondiftion]),
			[IsActive] = ISNULL(@IsActive, [IsActive]),
			[UpdatedBy] = ISNULL(@UpdatedBy, [UpdatedBy]),
			[UpdatedOn] = GETDATE()
		WHERE
			[AssetID] = @AssetID;

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