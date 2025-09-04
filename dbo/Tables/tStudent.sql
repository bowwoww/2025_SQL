CREATE TABLE [dbo].[tStudent] (
    [fStuId] CHAR (6)      NOT NULL,
    [fName]  NVARCHAR (30) NOT NULL,
    [fEmail] NVARCHAR (40) NULL,
    [fScore] INT           NULL,
    PRIMARY KEY CLUSTERED ([fStuId] ASC)
);


GO

