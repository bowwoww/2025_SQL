use Products;
go
--觸發程序在insert之後執行
--當新增資料到Products表時，觸發程序會自動執行
create or alter trigger getInsertedTable on Products
after insert
as
begin
    select * from inserted;
end
GO

--測試觸發程序
--新增一筆資料到Products表
insert into Products (ProductID, ProductName, Price, Description, Picture, CreatedDate, CataID)
values ('A2003', 'Test Product', 100, 'This is a test product', 'A2001.jpg', GETDATE(), 'A2');
GO

--觸發程序在update之後執行
--當更新Products表的資料時，觸發程序會自動執行
create or alter trigger getUpdateDataTable on Products
after update
as
begin
    select 'New',* from inserted
    union all
    select 'Old',* from deleted;
end
GO

UPDATE Products
SET Price = 150
WHERE ProductID = 'A2003';
GO

use Northwind;
go

create or alter TRIGGER checkOrderQtyPrice on OrderDetails
after INSERT
AS
begin
    declare @orderQty int, @price money , @ProductID int;
    declare @basePrice money;
    -- 從插入的資料中取得訂單數量和價格
    select @orderQty = Quantity, @price = UnitPrice, @ProductID = ProductID from inserted;
    select @basePrice = UnitPrice from Products where ProductID = @ProductID;

    if @price < @basePrice
    begin
    -- 如果價格小於基礎價格，則回滾交易並拋出錯誤
        RAISERROR('價格不能小於基礎價格', 16, 1);
        ROLLBACK TRANSACTION;
    end
end
go

-- 測試觸發程序
insert into OrderDetails (OrderID, ProductID, UnitPrice, Quantity)
values (10625, 12, 10, 50);
go

--新增資料時如果ID已出現則從insert變成update
create or alter trigger checkProductID on Products
INSTEAD OF INSERT
AS
BEGIN
    declare @ProductID int;
    -- 檢查插入的資料中是否已存在相同的ProductID
    select @ProductID = ProductID from Products where ProductID =(select ProductID from inserted);
    if @ProductID is not null
    BEGIN
        -- 如果存在，則更新現有的資料
        update Products
        set ProductName = i.ProductName,
            SupplierID = i.SupplierID,
            CategoryID = i.CategoryID,
            QuantityPerUnit = i.QuantityPerUnit,
            UnitPrice = i.UnitPrice,
            UnitsInStock = i.UnitsInStock,
            UnitsOnOrder = i.UnitsOnOrder,
            ReorderLevel = i.ReorderLevel,
            Discontinued = i.Discontinued
        from inserted i
        where Products.ProductID = @ProductID;
    END
    else
    BEGIN
        -- 如果不存在，則插入新的資料
        insert into Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
        select ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
        from inserted;
    END
END
go

-- 測試觸發程序 ProductID為 Identity
set identity_insert Products on;
insert into Products (ProductID,ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
values (78,'New Product 2', 1, 1, '10 boxes', 20.00, 100, 0, 10, 0);
set identity_insert Products off;
go

--DDL Trigger
--當Products表被刪除時，觸發程序會自動執行

use Products;
go
--將資料庫的資料表設定成唯獨
create or alter trigger preventDropTable on database 
for drop_table, alter_table
as
begin
    raiserror('不允許刪除資料表', 16, 1);
    rollback transaction;
end
GO

use Products;
create table testTable (id int);
drop table testTable;
--如果執行上面的drop table會報錯

--停用觸發程序
disable trigger preventDropTable on database;
--啟用觸發程序
enable trigger preventDropTable on database;