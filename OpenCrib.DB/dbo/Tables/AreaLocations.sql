CREATE TABLE [dbo].[AreaLocations] (
    [AreaLocationID]          INT            IDENTITY (1, 1) NOT NULL,
    [AreaLocationTypeID]      INT            NOT NULL,
    [AreaLocationName]        NVARCHAR (250) CONSTRAINT [DF_AreaLocations_AreaLocationName] DEFAULT ('') NOT NULL,
    [AreaLocationCode]        NVARCHAR (150) CONSTRAINT [DF_AreaLocations_AreaLocationCode] DEFAULT ('') NOT NULL,
    [AreaLocationDescription] NVARCHAR (500) CONSTRAINT [DF_AreaLocations_AreaLocationDescription] DEFAULT ('') NOT NULL,
    [AreaLocationActive]      BIT            CONSTRAINT [DF_AreaLocations_AreaLocationActive] DEFAULT ((1)) NOT NULL,
    [UpdatedBy]               INT            NOT NULL,
    [UpdatedOn]               DATETIME2 (3)  CONSTRAINT [DF_AreaLocations_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AreaLocations] PRIMARY KEY CLUSTERED ([AreaLocationID] ASC),
    CONSTRAINT [FK_AreaLocations_AreaLocationTypes] FOREIGN KEY ([AreaLocationTypeID]) REFERENCES [dbo].[AreaLocationTypes] ([AreaLocationTypeID]),
    CONSTRAINT [FK_AreaLocations_Users] FOREIGN KEY ([UpdatedBy]) REFERENCES [dbo].[Users] ([UserID])
);

