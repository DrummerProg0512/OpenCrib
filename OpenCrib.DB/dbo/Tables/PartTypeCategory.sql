CREATE TABLE [dbo].[PartTypeCategory] (
    [PartTypeCategoryID]  INT             NOT NULL,
    [PartTypeName]        NVARCHAR (150)  CONSTRAINT [DF_PartTypeCategory_PartTypeName] DEFAULT ('') NOT NULL,
    [PartTypeActive]      BIT             CONSTRAINT [DF_PartTypeCategory_PartTypeActive] DEFAULT ((1)) NOT NULL,
    [PartTypeDescription] NVARCHAR (1050) CONSTRAINT [DF_PartTypeCategory_PartTypeDescription] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_PartTypeCategory] PRIMARY KEY CLUSTERED ([PartTypeCategoryID] ASC)
);

