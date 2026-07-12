CREATE TABLE [dbo].[PartItemsAttachments] (
    [PartsItemsAttachmentID] INT             IDENTITY (1, 1) NOT NULL,
    [PartID]                 INT             NOT NULL,
    [ImageData]              VARBINARY (MAX) NOT NULL,
    [FileName]               NVARCHAR (255)  NOT NULL,
    [FileDescription]        NVARCHAR (500)  NOT NULL,
    [FileType]               NVARCHAR (10)   NOT NULL,
    [MimeType]               NVARCHAR (50)   NOT NULL,
    [FileSize]               INT             NOT NULL,
    [ImageActive]            BIT             CONSTRAINT [DF_PartsItemsAttachments_ImageActive] DEFAULT ((1)) NOT NULL,
    [UploadedOn]             DATETIME2 (3)   CONSTRAINT [DF_PartsItemsAttachments_UploadedOn] DEFAULT (getdate()) NOT NULL,
    [UploadedBy]             INT             NOT NULL,
    CONSTRAINT [PK_PartsItemsAttachments] PRIMARY KEY CLUSTERED ([PartsItemsAttachmentID] ASC),
    CONSTRAINT [FK_PartItemsAttachments_PartsItems] FOREIGN KEY ([PartID]) REFERENCES [dbo].[PartsItems] ([PartID]),
    CONSTRAINT [FK_PartItemsAttachments_Users] FOREIGN KEY ([UploadedBy]) REFERENCES [dbo].[Users] ([UserID])
);

