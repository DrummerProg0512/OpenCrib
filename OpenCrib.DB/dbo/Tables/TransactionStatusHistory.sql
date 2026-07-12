CREATE TABLE [dbo].[TransactionStatusHistory] (
    [TransactionStatusHistory] BIGINT          IDENTITY (1, 1) NOT NULL,
    [TransactionID]            BIGINT          NOT NULL,
    [TransactionStatusID]      INT             NOT NULL,
    [Notes]                    NVARCHAR (1024) NULL,
    [UpdatedBy]                INT             NOT NULL,
    [UpdatedOn]                DATETIME2 (3)   CONSTRAINT [DF_TransactionStatusHistory_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TransactionStatusHistory] PRIMARY KEY CLUSTERED ([TransactionStatusHistory] ASC),
    CONSTRAINT [FK_TransactionStatusHistory_TransactionHistory] FOREIGN KEY ([TransactionID]) REFERENCES [dbo].[TransactionHistory] ([TransactionID]),
    CONSTRAINT [FK_TransactionStatusHistory_TransactionStatus] FOREIGN KEY ([TransactionStatusID]) REFERENCES [dbo].[TransactionStatus] ([TransactionStatusID]),
    CONSTRAINT [FK_TransactionStatusHistory_Users] FOREIGN KEY ([UpdatedBy]) REFERENCES [dbo].[Users] ([UserID])
);

