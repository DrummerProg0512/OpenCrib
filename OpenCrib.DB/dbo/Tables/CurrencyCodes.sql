CREATE TABLE [dbo].[CurrencyCodes] (
    [CurrencyCodeID]    INT            IDENTITY (1, 1) NOT NULL,
    [CountryName]       NVARCHAR (250) CONSTRAINT [DF_CurrencyCodes_CountryName] DEFAULT ('') NOT NULL,
    [CurrencyName]      NVARCHAR (150) CONSTRAINT [DF_CurrencyCodes_CurrencyName] DEFAULT ('') NOT NULL,
    [CurrencyCode]      NVARCHAR (20)  CONSTRAINT [DF_CurrencyCodes_CurrencyCode] DEFAULT ('') NOT NULL,
    [IsDefaultCurrency] BIT            NOT NULL,
    [UpdatedBy]         INT            NOT NULL,
    [UpdatedOn]         DATETIME2 (7)  CONSTRAINT [DF_CurrencyCodes_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_CurrencyCodes] PRIMARY KEY CLUSTERED ([CurrencyCodeID] ASC)
);

