use MessageBoard;
go

create or alter view vAllMessages
AS
    SELECT M.Sender,
        R.Sender as ResponseSender,
        R.SentDate,
        R.Body
    FROM Messages as M
    INNER JOIN Responses as R ON M.id = R.id;
go


select * from vAllMessages;
GO

--集合運算

--union 只要不重複就會顯示,重複部分僅顯示一次
select Sender, SentDate, Body from Messages
union
select Sender, SentDate, Body from Responses;

--intersect 只會顯示兩個集合都有的部分
select Sender, SentDate, Body from Messages
intersect
select Sender, SentDate, Body from Responses;

--except 只會顯示第一個集合有,第二個集合沒有的部分
select Sender, SentDate, Body from Messages
except
select Sender, SentDate, Body from Responses;



--CTE 遞迴
use Northwind;
go

with EmployeeCTE as (
    select EmployeeID, LastName, FirstName, 1 as Tier
    from Employees
    where ReportsTo is null
    union all
    select e.EmployeeID, e.LastName, e.FirstName, ecte.Tier + 1
    from Employees e
    inner join EmployeeCTE ecte on e.ReportsTo = ecte.EmployeeID
) 
    select EmployeeID, LastName, FirstName, Tier
    from EmployeeCTE
    order by Tier, LastName;
GO

create or alter view vEmployeeHierarchy
AS
    with EmployeeCTE as (
        select EmployeeID, LastName, FirstName, 1 as Tier
        from Employees
        where ReportsTo is null
        union all
        select e.EmployeeID, e.LastName, e.FirstName, ecte.Tier + 1
        from Employees e
        inner join EmployeeCTE ecte on e.ReportsTo = ecte.EmployeeID
    )
    select EmployeeID, LastName, FirstName, Tier
    from EmployeeCTE;
go

select * from vEmployeeHierarchy;