
CREATE PROCEDURE [dbo].[usp_PartsItems_Select]
    @PartID INT = NULL,
    @PartName NVARCHAR(250) = NULL,
    @PartCode NVARCHAR(250) = NULL,
    @VendorID INT = NULL,
    @PartTypeCategoryID INT = NULL,
    @PartUsageTypeID INT = NULL,
    @PartTrackingTypeID INT = NULL,
    @PartActive BIT = NULL,
    @UpdatedBy INT = NULL,
    @UpdatedOnStartDate VARCHAR(19) = NULL,  -- Format: 'YYYY-MM-DD HH:mm:ss'
    @UpdatedOnEndDate VARCHAR(19) = NULL     -- Format: 'YYYY-MM-DD HH:mm:ss'
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Normalize empty strings to NULL
        SET @PartName = NULLIF(@PartName, '');
        SET @PartCode = NULLIF(@PartCode, '');
        SET @UpdatedOnStartDate = NULLIF(@UpdatedOnStartDate, '');
        SET @UpdatedOnEndDate = NULLIF(@UpdatedOnEndDate, '');
        
        SELECT
            pi.[PartID],
            pi.[PartName],
            pi.[PartDescription],
            pi.[VendorID],
            pvc.[VendorID] AS [VendorIDRef],
            pvc.VendorName AS [VendorName],
            pi.[PartItemCost],
            pi.[PartItemMin],
            pi.[PartItemMax],
            pi.[ShelfLife],
            pi.[PartTypeCategoryID],
            ptc.[PartTypeCategoryID] AS [PartTypeCategoryIDRef],
            ptc.PartTypeName,
            pi.[PartCode],
            pi.[PartActive],
            pi.[UpdatedBy],
            u.[UserID],
            u.[UserName],
            pi.[UOM_ID],
            uom.[UOM_ID] AS [UOM_IDRef],
            uom.[UOM_Name],
            pi.[PartUsageTypeID],
            put.[PartUsageTypeID] AS [PartUsageTypeIDRef],
            put.UsageTypeName,
            pi.[PartTrackingTypeID],
            ptt.[PartTrackingTypeID] AS [PartTrackingTypeIDRef],
            ptt.[TrackingTypeName],
            pi.[UpdatedOn]
        FROM
            [dbo].[PartsItems] pi
            INNER JOIN [dbo].[ProvidersVendorsCompanies] pvc ON pi.[VendorID] = pvc.[VendorID]
            INNER JOIN [dbo].[PartTypeCategory] ptc ON pi.[PartTypeCategoryID] = ptc.[PartTypeCategoryID]
            INNER JOIN [dbo].[Users] u ON pi.[UpdatedBy] = u.[UserID]
            INNER JOIN [dbo].[UOMs] uom ON pi.[UOM_ID] = uom.[UOM_ID]
            INNER JOIN [dbo].[PartUsageTypes] put ON pi.[PartUsageTypeID] = put.[PartUsageTypeID]
            INNER JOIN [dbo].[PartTrackingTypes] ptt ON pi.[PartTrackingTypeID] = ptt.[PartTrackingTypeID]
        WHERE
            -- Primary key filter: if provided and valid, search only by ID
            (
                (ISNULL(@PartID, 0) > 0 AND pi.[PartID] = @PartID)
                OR
                -- Otherwise, search by remaining fields
                (ISNULL(@PartID, 0) = 0
                    AND (@PartName IS NULL OR pi.[PartName] LIKE '%' + @PartName + '%')
                    AND (@PartCode IS NULL OR pi.[PartCode] LIKE '%' + @PartCode + '%')
                    AND (ISNULL(@VendorID, 0) = 0 OR pi.[VendorID] = @VendorID)
                    AND (ISNULL(@PartTypeCategoryID, 0) = 0 OR pi.[PartTypeCategoryID] = @PartTypeCategoryID)
                    AND (ISNULL(@PartUsageTypeID, 0) = 0 OR pi.[PartUsageTypeID] = @PartUsageTypeID)
                    AND (ISNULL(@PartTrackingTypeID, 0) = 0 OR pi.[PartTrackingTypeID] = @PartTrackingTypeID)
                    AND (@PartActive IS NULL OR pi.[PartActive] = @PartActive)
                    AND (ISNULL(@UpdatedBy, 0) = 0 OR pi.[UpdatedBy] = @UpdatedBy)
                    AND (@UpdatedOnStartDate IS NULL OR pi.[UpdatedOn] >= CONVERT(DATETIME2, @UpdatedOnStartDate))
                    AND (@UpdatedOnEndDate IS NULL OR pi.[UpdatedOn] <= CONVERT(DATETIME2, @UpdatedOnEndDate))
                )
            )
        ORDER BY
            pi.[PartID] DESC;
        
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