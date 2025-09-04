use MySchool;
go

create or alter FUNCTION getCourseID(@DeptID nchar(1))

RETURNS nchar(5)
AS
BEGIN
    DECLARE @CourseID nvarchar(5);
    DECLARE @count int;

    select @count = count(*) 
    from Course
    where DeptID = @DeptID

    set @count = @count + 1;
    set @CourseID = 'C' + @DeptID;
    set @CourseID = @CourseID + right('00' + cast(@count as nvarchar(3)), 3);

    RETURN @CourseID;
END;
go

declare @id nchar(5);
set @id = dbo.getCourseID('A');
print 'New Course ID for Department A is: ' + @id;
GO

insert into Course (CourseID, CourseName, Credit, Hour, DeptID)
values (dbo.getCourseID('A'), 'Database Systems', 3, 2, 'A');
insert into Course (CourseID, CourseName, Credit, Hour, DeptID)
values (dbo.getCourseID('A'), 'Operating Systems', 3, 3, 'A');
insert into Course (CourseID, CourseName, Credit, Hour, DeptID)
values (dbo.getCourseID('A'), 'Computer Networks', 3, 5, 'A');
insert into Course (CourseID, CourseName, Credit, Hour, DeptID)
values (dbo.getCourseID('A'), 'Software Engineering', 3, 4, 'A');