CREATE TABLE [dbo].[AreaLocationTypes] (
    [AreaLocationTypeID]     INT            IDENTITY (1, 1) NOT NULL,
    [AreaLocationTypeName]   NVARCHAR (150) CONSTRAINT [DF_AreaLocationTypes_AreaLocationTypeName] DEFAULT ('') NOT NULL,
    [AreaLocationTypeActive] BIT            CONSTRAINT [DF_AreaLocationTypes_AreaLocationTypeActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_AreaLocationTypes] PRIMARY KEY CLUSTERED ([AreaLocationTypeID] ASC)
);

