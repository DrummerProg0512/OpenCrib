CREATE TABLE [dbo].[PartStorageLocations] (
    [PartStorageLocationID] INT             IDENTITY (1, 1) NOT NULL,
    [StorageLocationID]     INT             NOT NULL,
    [PartID]                INT             NOT NULL,
    [Qty]                   DECIMAL (10, 2) NOT NULL,
    [UpdatedBy]             INT             NOT NULL,
    [UpdatedOn]             DATETIME2 (3)   CONSTRAINT [DF_PartStorageLocations_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_PartStorageLocations] PRIMARY KEY CLUSTERED ([PartStorageLocationID] ASC),
    CONSTRAINT [FK_PartStorageLocations_PartsItems] FOREIGN KEY ([PartID]) REFERENCES [dbo].[PartsItems] ([PartID]),
    CONSTRAINT [FK_PartStorageLocations_StorageLocations] FOREIGN KEY ([StorageLocationID]) REFERENCES [dbo].[StorageLocations] ([StorageLocationID]),
    CONSTRAINT [FK_PartStorageLocations_Users] FOREIGN KEY ([UpdatedBy]) REFERENCES [dbo].[Users] ([UserID])
);

