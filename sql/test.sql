--1. 請試寫一合併查詢，查詢出訂購日期落在1996年7月並指定送貨方式為「快遞」的有訂單之訂貨明細資料，
--並列出 訂單號碼、產品類別名稱、產品名稱、產品訂購單價、產品訂購數量、產品價錢小計、客戶編號、客戶名稱、
--收貨人名字、訂購日期、處理訂單員工的姓名、貨運公司、供應商名稱 等資料項目，
--其中產品價錢小計請以四捨五入計算至整數位。

select
    o.訂單號碼,
    pc.類別名稱,
    p.產品,
    d.單價,
    d.數量,
    ROUND(d.單價 * d.數量, 0) AS 產品價錢小計,
    c.客戶編號,
    c.公司名稱,
    o.收貨人,
    o.訂單日期,
    e.姓名 AS 處理訂單員工姓名,
    f.貨運公司名稱,
    s.供應商
from dbo.訂貨主檔 as o
inner join dbo.訂貨明細 as d on o.訂單號碼 = d.訂單號碼
inner join dbo.產品資料 as p on d.產品編號 = p.產品編號
inner join dbo.產品類別 as pc on p.類別編號 = pc.類別編號
inner join dbo.客戶 as c on o.客戶編號 = c.客戶編號
inner join dbo.員工 as e on o.員工編號 = e.員工編號
inner join dbo.供應商 as s on p.供應商編號 = s.供應商編號
inner join dbo.貨運公司 as f on o.送貨方式 = f.貨運公司編號
where o.訂單日期 between '1996-07-01' and '1996-07-31' and f.貨運公司名稱 = '快遞'

--2. 請試寫一合併查詢，查詢客戶「山山銀行」歷年來所訂購的所有產品，並統計出各種產品的訂購數量
--輸出欄立為客戶編號、公司名稱、聯絡人、產品名稱、訂購數量

select
    c.客戶編號,
    c.公司名稱,
    c.連絡人,
    p.產品,
    sum(d.數量) as 訂購數量
from dbo.訂貨主檔 as o
inner join dbo.訂貨明細 as d on o.訂單號碼 = d.訂單號碼
inner join dbo.產品資料 as p on d.產品編號 = p.產品編號
inner join dbo.客戶 as c on o.客戶編號 = c.客戶編號
where c.公司名稱 = '山山銀行'
group by c.客戶編號, c.公司名稱, c.連絡人, p.產品

--3. 請利用exists運算子配合子查詢式，找出哪些客戶從未下過訂單，並列出客戶的所有欄位。
--(不可用到in運算，亦不可用合併查詢式) 

select *
from dbo.客戶 as c
where not exists (
    select *
    from dbo.訂貨主檔 as o
    where o.客戶編號 = c.客戶編號
)

--4. 請利用in運算子配合子查詢式，查詢哪些員工有處理過訂單，並列出員工的員工編號、姓名、職稱、內部分機號碼、
--附註欄位。(不可用到exists運算，亦不可用合併查詢式) 

SELECT
    e.員工編號,
    e.姓名,
    e.職稱,
    e.內部分機號碼,
    e.附註
from 
    dbo.員工 as e
where e.員工編號 in (
    select distinct o.員工編號
    from dbo.訂貨主檔 as o
)
ORDER BY e.員工編號

--5. 請合併查詢與子查詢兩種寫法，列出1998年度所有被訂購過的產品資料，並列出產品的所有欄位，且依產品編號由小到大排序。
--(寫合併查詢時不得用任何子查詢式，寫子查詢時不得用任何合併查詢式)

-- 合併查詢寫法
SELECT DISTINCT
    p.*
FROM dbo.產品資料 as p
INNER JOIN dbo.訂貨明細 as d ON p.產品編號 = d.產品編號
INNER JOIN dbo.訂貨主檔 as o ON d.訂單號碼 = o.訂單號碼
WHERE o.訂單日期 between '1998-01-01' AND '1998-12-31'
ORDER BY p.產品編號
-- 子查詢寫法
SELECT *
FROM dbo.產品資料 as p
WHERE p.產品編號 IN (
    SELECT d.產品編號
    FROM dbo.訂貨明細 as d
    WHERE d.訂單號碼 IN (
        SELECT o.訂單號碼
        FROM dbo.訂貨主檔 as o
        WHERE o.訂單日期 >= '1998-01-01' AND o.訂單日期 < '1999-01-01'
    )
)
ORDER BY p.產品編號