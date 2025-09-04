use MySchool;
go

create or alter proc InsertDeptmentData
    @DeptID nchar(1),
    @DeptName nvarchar(30)
as
begin
    if exists (select * from Department where DeptID = @DeptID)
    begin
        print 'Department with ID ' + @DeptID + ' already exists.';
        return;
    end
    if exists (select * from Department where DeptName = @DeptName)
    begin
        print 'Department with name ' + @DeptName + ' already exists.';
        return;
    end
    insert into Department (DeptID, DeptName)
    values (@DeptID, @DeptName);
end
GO

exec InsertDeptmentData 'A', 'Computer Science';
exec InsertDeptmentData 'B', 'Electrical Engineering';
exec InsertDeptmentData 'B', 'Mechanical Engineering';
exec InsertDeptmentData 'C', 'Computer Science';