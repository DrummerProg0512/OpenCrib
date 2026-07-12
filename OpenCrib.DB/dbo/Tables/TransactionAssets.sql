CREATE TABLE [dbo].[TransactionAssets] (
    [TransactionAssetID] BIGINT IDENTITY (1, 1) NOT NULL,
    [TransactionID]      BIGINT NOT NULL,
    [AssetID]            BIGINT NOT NULL,
    CONSTRAINT [PK_TransactionAssets] PRIMARY KEY CLUSTERED ([TransactionAssetID] ASC),
    CONSTRAINT [FK_TransactionAssets_PartAssets] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[PartAssets] ([AssetID]),
    CONSTRAINT [FK_TransactionAssets_TransactionHistory] FOREIGN KEY ([TransactionID]) REFERENCES [dbo].[TransactionHistory] ([TransactionID])
);

