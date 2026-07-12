CREATE TABLE [dbo].[StorageLocationTypes] (
    [StorageLocationTypeID]     INT            IDENTITY (1, 1) NOT NULL,
    [StorageLocationTypeName]   NVARCHAR (150) CONSTRAINT [DF_StorageLocationTypes_StorageLocationTypeName] DEFAULT ('') NOT NULL,
    [StorageLocationTypeActive] BIT            CONSTRAINT [DF_StorageLocationTypes_StorageLocationTypeActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_StorageLocationTypes] PRIMARY KEY CLUSTERED ([StorageLocationTypeID] ASC)
);

