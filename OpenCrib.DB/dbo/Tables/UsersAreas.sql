CREATE TABLE [dbo].[UsersAreas] (
    [UsersAreasID]    INT           IDENTITY (1, 1) NOT NULL,
    [AreaLocationID]  INT           NOT NULL,
    [UserID]          INT           NOT NULL,
    [UpdatedOn]       DATETIME2 (7) NOT NULL,
    [UpdatedBy]       INT           NOT NULL,
    [UsersAreaActive] BIT           CONSTRAINT [DF_UsersAreas_UsersAreaActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UsersAreas] PRIMARY KEY CLUSTERED ([UsersAreasID] ASC),
    CONSTRAINT [FK_UsersAreas_AreaLocations] FOREIGN KEY ([AreaLocationID]) REFERENCES [dbo].[AreaLocations] ([AreaLocationID]),
    CONSTRAINT [FK_UsersAreas_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

