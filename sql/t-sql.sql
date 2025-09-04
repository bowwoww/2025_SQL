-- Write your own SQL object definition here, and it'll be included in your package.
print 'Hello, World!';

select 'Hello, World!' as Greeting;

declare @MyName nvarchar(50) = 'John Doe';
print 'My name is ' + @MyName;

declare @Number int;
set @Number = 42;
select @Number=777;

print @Number;
print 'The number is: ' + cast(@Number as nvarchar(10));

--T Sql 變數不分大小寫

declare @name NVARCHAR(20);

select @name = 姓名
from [北風].dbo.員工
where 員工編號 = 1;

print 'The employee name is: ' + @name;

declare @birthday DATETIME = '1980-01-01';
print '生日是' + convert(NVARCHAR(20), @birthday, 111);


DECLARE @dday DATETIME;
select @dday = 要貨日期
from [北風].dbo.訂貨主檔
where 訂單號碼 = 10248;
print '要貨日期是: ' + convert(NVARCHAR(20), @dday, 111);

-- T-Sql 建立新資料表並套入員工資料表同時自己新增一筆
declare @myTable table (
    [name] NVARCHAR(50),
    [birtday] DATETIME,
    [tel] NVARCHAR(20),
    [note] NVARCHAR(200)
)

insert into @myTable values (
    'John Doe',
    '1980-01-01',
    '123-456-7890',
    'This is a note.'
);
insert into @myTable select 
    A.姓名,
    A.出生日期,
    A.電話號碼,
    A.附註
    from [北風].dbo.員工 as A

select * from @myTable;

-- T-SQL 條件判斷
declare @height int = 130;
-- if else 不使用{} 而使用 begin end
if @height > 140
BEGIN
    print '全票';
END
else if @height >= 120
BEGIN
    print '半票';
END
else
BEGIN
    print '免費';
END

-- T-sql case
declare @score int = 85;
select 
    case 
        when @score >= 90 then 'A'
        when @score >= 80 then 'B'
        when @score >= 70 then 'C'
        when @score >= 60 then 'D'
        else 'F'
    end as Grade;
GO

select A.員工編號,
        A.姓名,
        A.稱呼,
        case A.稱呼
            when '先生' then '男性'
            when '小姐' then '女性'
            else '未知性別'
        end as 性別
from [北風].dbo.員工 as A

declare @score int = 85;
declare @result NVARCHAR(10);
set @result = 
    case 
        when @score >= 90 then 'A'
        when @score >= 80 then 'B'
        when @score >= 70 then 'C'
        when @score >= 60 then 'D'
        else 'F'
    end;
print 'Your grade is: ' + @result;

-- T-SQL while loop
declare @i int = 1,@sum int = 0;
while @i <= 10
BEGIN
    set @sum = @sum + @i;
    set @i = @i + 1;
END
print @sum;
GO

declare @i int = 0,@star nvarchar(20) = ' ';
while @i < 10
BEGIN
    set @star = @star + '*';
    print @star;
    set @i = @i + 1;
end
go
