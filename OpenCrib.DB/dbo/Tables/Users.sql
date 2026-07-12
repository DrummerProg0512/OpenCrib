CREATE TABLE [dbo].[Users] (
    [UserID]       INT            IDENTITY (1, 1) NOT NULL,
    [UserName]     NVARCHAR (150) CONSTRAINT [DF_Users_UserName] DEFAULT ('') NOT NULL,
    [UserLastName] NVARCHAR (150) CONSTRAINT [DF_Users_UserLastName] DEFAULT ('') NOT NULL,
    [UserCode]     NVARCHAR (50)  CONSTRAINT [DF_Users_UserCode] DEFAULT ('') NOT NULL,
    [EncPassword]  NVARCHAR (500) CONSTRAINT [DF_Users_EncPassword] DEFAULT ('') NOT NULL,
    [UserEmail]    NVARCHAR (250) CONSTRAINT [DF_Users_UserEmail] DEFAULT ('') NOT NULL,
    [UserActive]   BIT            CONSTRAINT [DF_Users_UserActive] DEFAULT ((1)) NOT NULL,
    [UserRoleID]   INT            NOT NULL,
    [UserTypeID]   INT            NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [FK_Users_UserRoles] FOREIGN KEY ([UserRoleID]) REFERENCES [dbo].[UserRoles] ([UserRoleID]),
    CONSTRAINT [FK_Users_UserTypes] FOREIGN KEY ([UserTypeID]) REFERENCES [dbo].[UserTypes] ([UserTypeID])
);

