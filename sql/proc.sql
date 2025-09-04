use HotelSysDB;
go


create or alter PROC getMemberWithTel
    @memID nchar(5)
as
begin
    select m.MemberID, m.Name, mt.Tel, m.Birthday, m.Address
    from Member as m
    inner join MemberTel as mt on m.MemberID = mt.MemberID
    where m.MemberID = @memID;
end
go

exec getMemberWithTel 'A0002';