CREATE TABLE [dbo].[PartCostHistory] (
    [PartCostHistoryID] INT             IDENTITY (1, 1) NOT NULL,
    [PartID]            INT             NOT NULL,
    [CostAmount]        DECIMAL (12, 2) NOT NULL,
    [CurrencyCodeID]    INT             NOT NULL,
    [ExchangeRate]      DECIMAL (12, 2) NOT NULL,
    [ExchangeRateDate]  DATE            NOT NULL,
    [UpdatedBy]         INT             NOT NULL,
    [UpdatedOn]         DATETIME2 (3)   CONSTRAINT [DF_PartCostHistory_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PartCostHistory] PRIMARY KEY CLUSTERED ([PartCostHistoryID] ASC),
    CONSTRAINT [FK_PartCostHistory_CurrencyCodes] FOREIGN KEY ([CurrencyCodeID]) REFERENCES [dbo].[CurrencyCodes] ([CurrencyCodeID]),
    CONSTRAINT [FK_PartCostHistory_PartsItems] FOREIGN KEY ([PartID]) REFERENCES [dbo].[PartsItems] ([PartID])
);

