alter table [Products]
    add CataID nchar(2) not null;
go

alter table [Products]
    add constraint FK_OrderDetail_Order foreign key (CataID) references Category(CateID);
--    add foreign key (CataID) references Category(CateID);
go

alter table [OrderDetail]
    add foreign key (OrderID) references [Order](OrderID);
--    add foreign key (OrderID) references [Order](OrderID);
go

--移除MemberPoint 但是因為MemberPoint 有 Default 所以不能直接刪除
-- 需要先移除 Default 再刪除欄位
alter table Member
    drop column MemberPoint;

-- 先移除 MemberPoint 的 Default Constraint
alter table Member
    drop constraint [DF__Member__MemberPo__3E52440B];
GO
alter table Member
    drop column MemberPoint;
go

alter table Products
drop CONSTRAINT [FK__Products__CataID__49C3F6B7];
alter table Products
drop column CataID;

drop table if exists [Member];