use northwind;
GO

select * 
from Employees as E
where E.HireDate >= '1993-01-01'
go

select *
from Orders as O
where O.ShipPostalCode = '44087' or O.ShipPostalCode = '05022' or O.ShipPostalCode = '82520'
go

-- 如果根據庫存量取得前六筆而第六筆和第七筆的庫存量相同，則會顯示第六筆和第七筆
select top(6) with ties *
from Products as P
order by P.UnitsInStock desc;
go

select *
from Orders as O
where O.ShippedDate is null
go

select *
from OrderDetails as OD
where OD.Quantity BETWEEN 20 and 40
go

select avg(P.UnitPrice) as AveragePrice
from Products as P
where P.CategoryID = 2
group by P.CategoryID
go

select *
from Products as P
where P.UnitsInStock < P.ReorderLevel and P.UnitsOnOrder = 0
go

select OD.OrderID, count(OD.ProductID) as ProductCount 
from OrderDetails as OD
group by OD.OrderID
HAVING count(OD.ProductID) >= 5
go

select OD.OrderID , OD.UnitPrice * OD.Quantity * (1 - OD.Discount) as TotalPrice
from OrderDetails as OD
where OD.OrderID = '10263'
go

select P.SupplierID, count(P.ProductID) as ProductCount
from Products as P
group by P.SupplierID
go

SELECT OD.ProductID, avg(OD.UnitPrice) as AverageUnitPrice, avg(OD.Quantity) as AverageQuantity
from OrderDetails as OD
group by OD.ProductID
having avg(OD.Quantity) > 10
ORDER by OD.ProductID
go

SELECT O.OrderID,
    Cate.CategoryName,
    P.ProductName,
    OD.UnitPrice,
    OD.Quantity ,
    round(OD.UnitPrice * OD.Quantity * (1 - OD.Discount), 0) as TotalPrice,
    O.CustomerID,
    C.CompanyName as CustomerName,
    C.ContactName,
    O.OrderDate,
    E.FirstName + ' ' + E.LastName as EmployeeName,
    SH.CompanyName as ShipperName,
    S.CompanyName as SupplierName
from Orders as O
inner join OrderDetails as OD on O.OrderID = OD.OrderID
inner join Customers as C on O.CustomerID = C.CustomerID
inner join Employees as E on O.EmployeeID = E.EmployeeID
inner join Products as P on OD.ProductID = P.ProductID
inner join Categories as Cate on P.CategoryID = Cate.CategoryID
inner join Suppliers as S on P.SupplierID = S.SupplierID
inner join Shippers as Sh on O.ShipVia = Sh.ShipperID
where O.OrderDate BETWEEN '1996-07-01' and '1996-07-31' and Sh.CompanyName like 'United Package'
go

select *
from Customers as C
where not exists (select * from Orders as O where O.CustomerID = C.CustomerID)
go

select E.EmployeeID, E.FirstName, E.LastName,E.Title,E.PostalCode,E.Notes
from Employees as E
where E.EmployeeID in (select distinct O.EmployeeID from Orders as O)
go

select distinct P.*
from Products as P
inner join OrderDetails as OD on P.ProductID = OD.ProductID
inner join Orders as O on OD.OrderID = O.OrderID
where O.OrderDate between '1998-01-01' and '1998-12-31'
order by P.ProductID
go

select *
from Products as P
where P.ProductID in (select OD.ProductID from OrderDetails as OD where OD.OrderID in (
    select O.OrderID
    from Orders as O
    where O.OrderDate between '1998-01-01' and '1998-12-31'
))
order by P.ProductID
go
