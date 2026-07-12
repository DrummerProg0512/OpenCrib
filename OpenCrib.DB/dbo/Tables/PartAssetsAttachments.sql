CREATE TABLE [dbo].[PartAssetsAttachments] (
    [PartAssetsAttachmentID] INT             IDENTITY (1, 1) NOT NULL,
    [AssetID]                BIGINT          NOT NULL,
    [ImageData]              VARBINARY (MAX) NOT NULL,
    [FileName]               NVARCHAR (255)  NOT NULL,
    [FileDescription]        NVARCHAR (500)  CONSTRAINT [DF_PartAssetsAttachments_FileDescription] DEFAULT ('') NOT NULL,
    [FileType]               NVARCHAR (10)   CONSTRAINT [DF_PartAssetsAttachments_FileType] DEFAULT ('') NOT NULL,
    [MimeType]               NVARCHAR (50)   CONSTRAINT [DF_PartAssetsAttachments_MimeType] DEFAULT ('') NOT NULL,
    [FileSize]               INT             NOT NULL,
    [ImageActive]            BIT             CONSTRAINT [DF_PartAssetsAttachments_ImageActive] DEFAULT ((1)) NOT NULL,
    [UploadedOn]             DATETIME2 (3)   CONSTRAINT [DF_PartAssetsAttachments_UploadedOn] DEFAULT (getdate()) NOT NULL,
    [UploadedBy]             INT             NOT NULL,
    CONSTRAINT [PK_PartAssetsAttachments] PRIMARY KEY CLUSTERED ([PartAssetsAttachmentID] ASC),
    CONSTRAINT [FK_PartAssetsAttachments_PartAssets] FOREIGN KEY ([AssetID]) REFERENCES [dbo].[PartAssets] ([AssetID]),
    CONSTRAINT [FK_PartAssetsAttachments_Users] FOREIGN KEY ([UploadedBy]) REFERENCES [dbo].[Users] ([UserID])
);

