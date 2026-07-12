CREATE TABLE [dbo].[TransactionParts] (
    [TransactionPartID] BIGINT          IDENTITY (1, 1) NOT NULL,
    [TransactionID]     BIGINT          NOT NULL,
    [PartID]            INT             NOT NULL,
    [PartCostHistoryID] INT             NOT NULL,
    [UnitCost]          DECIMAL (12, 2) CONSTRAINT [DF_TransactionParts_UnitCost] DEFAULT ((0)) NOT NULL,
    [Qty]               DECIMAL (10, 2) CONSTRAINT [DF_TransactionParts_Qty] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TransactionParts] PRIMARY KEY CLUSTERED ([TransactionPartID] ASC),
    CONSTRAINT [FK_TransactionParts_PartCostHistory] FOREIGN KEY ([PartCostHistoryID]) REFERENCES [dbo].[PartCostHistory] ([PartCostHistoryID]),
    CONSTRAINT [FK_TransactionParts_PartsItems] FOREIGN KEY ([PartID]) REFERENCES [dbo].[PartsItems] ([PartID]),
    CONSTRAINT [FK_TransactionParts_TransactionHistory] FOREIGN KEY ([TransactionID]) REFERENCES [dbo].[TransactionHistory] ([TransactionID])
);

