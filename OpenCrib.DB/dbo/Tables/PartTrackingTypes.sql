CREATE TABLE [dbo].[PartTrackingTypes] (
    [PartTrackingTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [TrackingTypeName]   NVARCHAR (250) CONSTRAINT [DF_PartTrackingTypes_TrackingTypeName] DEFAULT ('') NOT NULL,
    [TrackingTypeActive] BIT            CONSTRAINT [DF_PartTrackingTypes_TrackingTypeActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_PartTrackingTypes] PRIMARY KEY CLUSTERED ([PartTrackingTypeID] ASC)
);

