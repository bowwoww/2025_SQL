create table Department (
    departID varchar(2) PRIMARY KEY,
    departName varchar(50) not null
);
GO

insert into Department (departID, departName) values
('01', 'Human Resources'),
('02', 'Finance'),
('03', 'Information Technology'),
('04', 'Marketing'),
('05', 'Sales');
go

alter table tStudent
    add FOREIGN KEY (departID) REFERENCES Department(departID);
go  