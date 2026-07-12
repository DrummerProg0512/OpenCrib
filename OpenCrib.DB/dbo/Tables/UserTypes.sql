CREATE TABLE [dbo].[UserTypes] (
    [UserTypeID]         INT            IDENTITY (1, 1) NOT NULL,
    [UserTypeName]       NVARCHAR (255) CONSTRAINT [DF_UserTypes_UserTypeName] DEFAULT ('') NOT NULL,
    [CostApprovalLevel]  INT            NOT NULL,
    [CostApprovalAmount] DECIMAL (18)   NOT NULL,
    [IsActive]           BIT            CONSTRAINT [DF_UserTypes_IsActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED ([UserTypeID] ASC)
);

