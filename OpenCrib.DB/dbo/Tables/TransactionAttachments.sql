CREATE TABLE [dbo].[TransactionAttachments] (
    [TransactionAttachmentID] INT             IDENTITY (1, 1) NOT NULL,
    [TransactionID]           BIGINT          NOT NULL,
    [ImageData]               VARBINARY (MAX) NOT NULL,
    [FileName]                NVARCHAR (255)  CONSTRAINT [DF_TransactionAttachments_FileName] DEFAULT ('') NOT NULL,
    [FileDescription]         NVARCHAR (500)  CONSTRAINT [DF_TransactionAttachments_FileDescription] DEFAULT ('') NOT NULL,
    [FileType]                NVARCHAR (10)   CONSTRAINT [DF_TransactionAttachments_FileType] DEFAULT ('') NOT NULL,
    [MimeType]                NVARCHAR (50)   CONSTRAINT [DF_TransactionAttachments_MimeType] DEFAULT ('') NOT NULL,
    [FileSize]                INT             NOT NULL,
    [ImageActive]             BIT             NOT NULL,
    [UploadedOn]              DATETIME2 (3)   CONSTRAINT [DF_TransactionAttachments_UploadedOn] DEFAULT (getdate()) NOT NULL,
    [UploadedBy]              INT             NOT NULL,
    CONSTRAINT [PK_TransactionAttachments] PRIMARY KEY CLUSTERED ([TransactionAttachmentID] ASC),
    CONSTRAINT [FK_TransactionAttachments_TransactionHistory] FOREIGN KEY ([TransactionID]) REFERENCES [dbo].[TransactionHistory] ([TransactionID]),
    CONSTRAINT [FK_TransactionAttachments_Users] FOREIGN KEY ([UploadedBy]) REFERENCES [dbo].[Users] ([UserID])
);

