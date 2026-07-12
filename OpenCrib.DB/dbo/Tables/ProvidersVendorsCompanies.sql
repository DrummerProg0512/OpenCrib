CREATE TABLE [dbo].[ProvidersVendorsCompanies] (
    [VendorID]        INT             IDENTITY (1, 1) NOT NULL,
    [VendorName]      NVARCHAR (250)  CONSTRAINT [DF_ProvidersVendorsCompanies_VendorName] DEFAULT ('') NOT NULL,
    [VendorShortName] NVARCHAR (150)  CONSTRAINT [DF_ProvidersVendorsCompanies_VendorShortName] DEFAULT ('') NOT NULL,
    [VendorURL]       NVARCHAR (500)  CONSTRAINT [DF_ProvidersVendorsCompanies_VendorURL] DEFAULT ('') NOT NULL,
    [VendorAddress]   NVARCHAR (2000) CONSTRAINT [DF_ProvidersVendorsCompanies_VendorAddress] DEFAULT ('') NOT NULL,
    [CompanyActive]   BIT             CONSTRAINT [DF_ProvidersVendorsCompanies_CompanyActive] DEFAULT ((1)) NOT NULL,
    [Phone1]          NVARCHAR (150)  CONSTRAINT [DF_ProvidersVendorsCompanies_Phone1] DEFAULT ('') NOT NULL,
    [Phone2]          NVARCHAR (150)  CONSTRAINT [DF_ProvidersVendorsCompanies_Phone2] DEFAULT ('') NOT NULL,
    [UpdatedBy]       INT             NOT NULL,
    [UpdatedOn]       DATETIME2 (7)   CONSTRAINT [DF_ProvidersVendorsCompanies_UpdatedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProvidersVendorsCompanies] PRIMARY KEY CLUSTERED ([VendorID] ASC),
    CONSTRAINT [FK_ProvidersVendorsCompanies_Users] FOREIGN KEY ([UpdatedBy]) REFERENCES [dbo].[Users] ([UserID])
);

