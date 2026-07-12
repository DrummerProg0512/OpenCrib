CREATE TABLE [dbo].[TransactionStatus] (
    [TransactionStatusID]     INT            IDENTITY (1, 1) NOT NULL,
    [TransactionStatusName]   NVARCHAR (100) CONSTRAINT [DF_TransactionStatus_TransactionStatusName] DEFAULT ('') NOT NULL,
    [TransactionStatusActive] BIT            CONSTRAINT [DF_TransactionStatus_TransactionStatusActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_TransactionStatus] PRIMARY KEY CLUSTERED ([TransactionStatusID] ASC)
);

