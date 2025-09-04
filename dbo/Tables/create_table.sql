-- Write your own SQL object definition here, and it'll be included in your package.
create DATABASE Products;
GO
USE Products;
GO
create table Category (
    CateID nchar(2) PRIMARY KEY not NULL,
    CateName NVARCHAR(20) NOT NULL
);
GO
create TABLE Products (
    ProductID NVARCHAR(5) PRIMARY KEY not NULL,
    ProductName NVARCHAR(40) NOT NULL,
    Price MONEY NOT NULL CHECK (Price >= 0),
    Description NVARCHAR(200) null,
    Picture NVARCHAR(12) not NULL,
    CreatedDate DATETIME DEFAULT GETDATE(),
    --CateID nchar(2) not null FOREIGN KEY REFERENCES Category(CateID),
    -- The foreign key constraint ensures that the CateID in Products must exist in Category
    --constraint FK_Category_Products foreign key (CateID) references Category(CateID)
);
GO
create table Member (
    MemberID NVARCHAR(6) PRIMARY KEY not NULL,
    Name NVARCHAR(30) NOT NULL,
    Gender bit NOT NULL,
    MemberPoint int NOT NULL DEFAULT 0,
    Account NVARCHAR(12) UNIQUE not null,
    Password NVARCHAR(20) not null,
    CreatedDate DATETIME DEFAULT GETDATE()
);

GO
create table [Order] (
    OrderID NVARCHAR(12) PRIMARY KEY not NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    MemberID NVARCHAR(6) not null FOREIGN KEY REFERENCES Member(MemberID),
    ContactName NVARCHAR(30) NOT NULL,
    ContactAddress NVARCHAR(100) NOT NULL
);
GO
create table OrderDetail (
    OrderID NVARCHAR(12) not null FOREIGN KEY REFERENCES [Order](OrderID),
    ProductID NVARCHAR(5) not null FOREIGN KEY REFERENCES Products(ProductID),
    Qty int NOT NULL DEFAULT 1,
    Price MONEY NOT NULL CHECK (Price >= 0),
    --table level
    PRIMARY KEY (OrderID, ProductID)
);
GO
--檢查當前連接資料庫的session
USE master;
SELECT 
    session_id, 
    host_name, 
    program_name, 
    login_name 
FROM sys.dm_exec_sessions
WHERE database_id = DB_ID('Products');

kill 63;

use master;
drop database Products;
GO



--移除 Products 資料庫的 Member 資料表
use Products;
drop table if exists Member;
go
