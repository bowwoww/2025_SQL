CREATE FUNCTION[dbo].[GenerateOrderID] ()
RETURNS NCHAR(12)
AS
BEGIN
    DECLARE @prefix CHAR(1) = 'R';
DECLARE @datePart CHAR(8) = CONVERT(CHAR(8), GETDATE(), 112); --yyyyMMdd
    DECLARE @lastNumber INT = 0;
DECLARE @newNumber VARCHAR(3);
DECLARE @newOrderID VARCHAR(20);

--取得當天最後一個OrderID流水號
    SELECT @lastNumber =
        ISNULL(MAX(CAST(RIGHT(OrderID, 3) AS INT)), 0)
    FROM [Order]
WHERE OrderID LIKE @prefix + @datePart + '%';

--流水號 + 1
    SET @lastNumber = @lastNumber + 1;

--格式化為三位數，不足補0
SET @newNumber = RIGHT('000' + CAST(@lastNumber AS VARCHAR(3)), 3);

--組成新的OrderID
    SET @newOrderID = @prefix + @datePart + @newNumber;

RETURN @newOrderID;
END
GO





CREATE proc[dbo].[AddNewOrder]
@ExpectedCheckInDate datetime,
    @ExpectedCheckOutDate datetime,
    @Note nvarchar(200),
    @MemberID  nchar(5),
    @PayCode nchar(2),
    @StatusCode nchar(1),
    @Cart nvarchar(max)
as
begin

	begin tran  --交易處理開始

	declare @orderID nchar(12) = dbo.GenerateOrderID()


	insert into  [Order]
values(@orderID, getDate(), @ExpectedCheckInDate, @ExpectedCheckOutDate, @Note,
    @MemberID, null, @PayCode, @StatusCode)  --資料來自表單


    if @@error = 0

    begin

        insert into[OrderDetail](OrderID, RoomID, Price)

        select @orderID, RID, Price from openjson(@Cart) with(RID nchar(5), Price money)

		if @@ERROR=0
			commit
		else
			rollback
	
	end
	else
		rollback


 end