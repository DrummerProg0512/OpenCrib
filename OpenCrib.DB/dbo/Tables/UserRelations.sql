CREATE TABLE [dbo].[UserRelations] (
    [UserRelationID]     INT IDENTITY (1, 1) NOT NULL,
    [UserID_Parent]      INT NOT NULL,
    [UserID_Child]       INT NOT NULL,
    [UserRelationActive] BIT CONSTRAINT [DF_UserRelations_UserRelationActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserRelations] PRIMARY KEY CLUSTERED ([UserRelationID] ASC),
    CONSTRAINT [FK_UserRelations_Users] FOREIGN KEY ([UserID_Parent]) REFERENCES [dbo].[Users] ([UserID]),
    CONSTRAINT [FK_UserRelations_Users1] FOREIGN KEY ([UserID_Child]) REFERENCES [dbo].[Users] ([UserID])
);

