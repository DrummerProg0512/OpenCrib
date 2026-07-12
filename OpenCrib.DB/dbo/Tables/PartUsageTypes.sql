CREATE TABLE [dbo].[PartUsageTypes] (
    [PartUsageTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [UsageTypeName]   NVARCHAR (250) CONSTRAINT [DF_PartUsageTypes_UsageTypeName] DEFAULT ('') NOT NULL,
    [UsageTypeActive] BIT            CONSTRAINT [DF_PartUsageTypes_UsageTypeActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_PartUsageTypes] PRIMARY KEY CLUSTERED ([PartUsageTypeID] ASC)
);

