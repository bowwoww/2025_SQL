update dbo.員工
set 附註 = 附註 + '米蟲'
where not exists (select *
from dbo.訂貨主檔
where dbo.員工.員工編號 = dbo.訂貨主檔.員工編號
);

update dbo.員工
set 附註 = 附註 + '米蟲'
from dbo.訂貨主檔 as o 
right join dbo.員工 as e
on e.員工編號 = o.員工編號
where o.員工編號 is null;


insert into 訂貨明細 values(10325 , 5,10 ,5 ,0 )
--修改資料現象
update 訂貨明細
set 產品編號=50
where 訂單號碼=10325 and 產品編號=5;

delete from 訂貨明細
where 訂單號碼=10325 and 產品編號=50;