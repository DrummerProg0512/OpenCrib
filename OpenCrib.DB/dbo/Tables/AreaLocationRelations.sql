CREATE TABLE [dbo].[AreaLocationRelations] (
    [AreaLocationRelationID] INT           IDENTITY (1, 1) NOT NULL,
    [AreaLocationParentID]   INT           NOT NULL,
    [AreaLocationChildID]    INT           NOT NULL,
    [UpdatedBy]              INT           NOT NULL,
    [UpdatedOn]              DATETIME2 (3) CONSTRAINT [DF_AreaLocationRelations_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_AreaLocationRelations] PRIMARY KEY CLUSTERED ([AreaLocationRelationID] ASC),
    CONSTRAINT [FK_AreaLocationRelations_AreaLocations] FOREIGN KEY ([AreaLocationParentID]) REFERENCES [dbo].[AreaLocations] ([AreaLocationID]),
    CONSTRAINT [FK_AreaLocationRelations_AreaLocations1] FOREIGN KEY ([AreaLocationChildID]) REFERENCES [dbo].[AreaLocations] ([AreaLocationID]),
    CONSTRAINT [FK_AreaLocationRelations_Users] FOREIGN KEY ([UpdatedBy]) REFERENCES [dbo].[Users] ([UserID])
);

