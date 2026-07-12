CREATE TABLE [dbo].[StorageLocations] (
    [StorageLocationID]          INT            IDENTITY (1, 1) NOT NULL,
    [StorageLocationTypeID]      INT            NOT NULL,
    [AreaLocationID]             INT            NOT NULL,
    [StorageLocationName]        NVARCHAR (250) CONSTRAINT [DF_StorageLocations_StorageLocationName] DEFAULT ('') NOT NULL,
    [StorageLocationCode]        NVARCHAR (150) CONSTRAINT [DF_StorageLocations_StorageLocationCode] DEFAULT ('') NOT NULL,
    [StorageLocationDescription] NVARCHAR (500) CONSTRAINT [DF_StorageLocations_StorageLocationDescription] DEFAULT ('') NOT NULL,
    [StorageLocationActive]      BIT            CONSTRAINT [DF_StorageLocations_StorageLocationActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_StorageLocations] PRIMARY KEY CLUSTERED ([StorageLocationID] ASC),
    CONSTRAINT [FK_StorageLocations_AreaLocations] FOREIGN KEY ([AreaLocationID]) REFERENCES [dbo].[AreaLocations] ([AreaLocationID]),
    CONSTRAINT [FK_StorageLocations_StorageLocationTypes] FOREIGN KEY ([StorageLocationTypeID]) REFERENCES [dbo].[StorageLocationTypes] ([StorageLocationTypeID])
);

