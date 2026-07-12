CREATE TABLE [dbo].[UserRoles] (
    [UserRoleID]     INT            IDENTITY (1, 1) NOT NULL,
    [UserRoleName]   NVARCHAR (100) CONSTRAINT [DF_UserRoles_UserRoleName] DEFAULT ('') NOT NULL,
    [UserRoleCode]   NVARCHAR (50)  CONSTRAINT [DF_UserRoles_UserRoleCode] DEFAULT ('') NOT NULL,
    [UserRoleActive] BIT            CONSTRAINT [DF_UserRoles_UserRoleActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED ([UserRoleID] ASC)
);

