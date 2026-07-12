CREATE TABLE [dbo].[PartAssets] (
    [AssetID]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [PartID]              INT             NOT NULL,
    [SerialNumber]        NVARCHAR (100)  CONSTRAINT [DF_PartAssets_SerialNumber] DEFAULT ('') NOT NULL,
    [AssetTag]            NVARCHAR (1024) CONSTRAINT [DF_PartAssets_AssetTag] DEFAULT ('') NOT NULL,
    [AssetStatusID]       INT             NOT NULL,
    [PurchaseDate]        DATE            NULL,
    [WarrantyExpiration]  DATE            NULL,
    [LastCalibrationDate] DATE            NULL,
    [NextCalibrationDate] DATE            NULL,
    [AssetCondiftion]     INT             NOT NULL,
    [IsActive]            BIT             CONSTRAINT [DF_PartAssets_IsActive] DEFAULT ((1)) NOT NULL,
    [UpdatedBy]           INT             NOT NULL,
    [UpdatedOn]           DATETIME2 (3)   CONSTRAINT [DF_PartAssets_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PartAssets] PRIMARY KEY CLUSTERED ([AssetID] ASC),
    CONSTRAINT [FK_PartAssets_PartsItems] FOREIGN KEY ([PartID]) REFERENCES [dbo].[PartsItems] ([PartID]),
    CONSTRAINT [FK_PartAssets_Users] FOREIGN KEY ([UpdatedBy]) REFERENCES [dbo].[Users] ([UserID])
);

