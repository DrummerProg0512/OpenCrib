
CREATE PROCEDURE [dbo].[usp_PartAssets_Select]
	@AssetID BIGINT = NULL,
	@PartID INT = NULL,
	@SerialNumber NVARCHAR(100) = NULL,
	@AssetTag NVARCHAR(1024) = NULL,
	@AssetStatusID INT = NULL,
	@IsActive BIT = NULL,
	@UpdatedBy INT = NULL,
	@UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
	@UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		-- Normalize empty strings to NULL
		SET @SerialNumber = NULLIF(@SerialNumber, '');
		SET @AssetTag = NULLIF(@AssetTag, '');
		SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
		SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');

		SELECT
			pa.[AssetID],
			pa.[PartID],
			pi.[PartID] AS [PartIDRef],
			pi.PartCode,
			pi.[PartName],
			pa.[SerialNumber],
			pa.[AssetTag],
			pa.[AssetStatusID],
			asst.[AssetStatusID] AS [AssetStatusIDRef],
			
			pa.[PurchaseDate],
			pa.[WarrantyExpiration],
			pa.[LastCalibrationDate],
			pa.[NextCalibrationDate],
			pa.[AssetCondiftion],
			pa.[IsActive],
			pa.[UpdatedBy],
			u.[UserID],
			u.[UserName],
			pa.[UpdatedOn]
		FROM
			[dbo].[PartAssets] pa
			INNER JOIN [dbo].[PartsItems] pi ON pa.[PartID] = pi.[PartID]
			INNER JOIN [dbo].PartAssets asst ON pa.[AssetStatusID] = asst.[AssetStatusID]
			INNER JOIN [dbo].[Users] u ON pa.[UpdatedBy] = u.[UserID]
		WHERE
			-- Primary key filter: if provided and valid, search only by ID
			(
				(ISNULL(@AssetID, 0) > 0 AND pa.[AssetID] = @AssetID)
				OR
				-- Otherwise, search by remaining fields
				(ISNULL(@AssetID, 0) = 0
					AND (ISNULL(@PartID, 0) = 0 OR pa.[PartID] = @PartID)
					AND (@SerialNumber IS NULL OR pa.[SerialNumber] LIKE '%' + @SerialNumber + '%')
					AND (@AssetTag IS NULL OR pa.[AssetTag] LIKE '%' + @AssetTag + '%')
					AND (ISNULL(@AssetStatusID, 0) = 0 OR pa.[AssetStatusID] = @AssetStatusID)
					AND (@IsActive IS NULL OR pa.[IsActive] = @IsActive)
					AND (ISNULL(@UpdatedBy, 0) = 0 OR pa.[UpdatedBy] = @UpdatedBy)
					AND (@UpdatedOnStartDate IS NULL OR pa.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
					AND (@UpdatedOnEndDate IS NULL OR pa.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
				)
			)
		ORDER BY
			pa.[AssetID] DESC;

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