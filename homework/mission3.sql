--if database MySchool exists, kill all connections and drop it
use master;
go
if exists (select * from sys.databases where name = 'MySchool')
begin
    declare @sql nvarchar(max);
    select @sql = 'kill ' + cast(spid as nvarchar(10)) + ';'
    from sys.sysprocesses
    where dbid = db_id('MySchool');
    exec sp_executesql @sql;
    drop database MySchool;
end
create database MySchool;
GO
use MySchool;
go


create table Department (
    DeptID nchar(1) PRIMARY KEY NOT NULL Check (DeptID Like '[A-Z]'),
    DeptName nvarchar(30) UNIQUE NOT NULL
);
go


create table Student (
    StudentID nchar(10) PRIMARY KEY NOT NULL,
    StuName nvarchar(20) NOT NULL,
    Tel nvarchar(20) NOT NULL,
    Address nvarchar(100),
    Birthday DATETIME,
    DeptID nchar(1) NOT NULL FOREIGN KEY REFERENCES Department(DeptID)
);
GO

create table Course (
    CourseID nchar(5) PRIMARY KEY NOT NULL,
    CourseName nvarchar(30) NOT NULL,
    Credit int NOT NULL DEFAULT 0,
    Hour int NOT NULL DEFAULT 2,
    DeptID nchar(1) NOT NULL FOREIGN KEY REFERENCES Department(DeptID)
);
go


create table SelectionDetail (
    StuID nchar(10) NOT NULL FOREIGN KEY REFERENCES Student(StudentID),
    CourseID nchar(5) NOT NULL FOREIGN KEY REFERENCES Course(CourseID),
    Year int NOT NULL DEFAULT YEAR(GETDATE()),
    Term tinyint NOT NULL,
    Score int NOT NULL DEFAULT 0,
    PRIMARY KEY (StuID, CourseID)
);
GO
