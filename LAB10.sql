'1. Write code to insert an order header
Your script to insert an order header must enable users to specify values for the order date, due date,
and customer ID. The SalesOrderID should be generated from the next value for the
SalesLT.SalesOrderNumber sequence and assigned to a variable. The script should then insert a record
into the SalesLT.SalesOrderHeader table using these values and a hard-coded value of ‘CARGO
TRANSPORT 5’ for the shipping method with default or NULL values for all other columns.
After the script has inserted the record, it should display the inserted SalesOrderID using the PRINT
command.'

===================建立暫存表==================
Create View  SalesLT.SalesOrderNumber1
as
select  SalesOrderID from SalesLT.SalesOrderHeader

--檢視暫存表內容
select * from SalesLT.SalesOrderNumber1
======================================================
DECLARE @SalesOrderID VARCHAR(100)
--select*from SalesLT.SalesOrderNumber SalesOrderID

SELECT @SalesOrderID =MAX(SalesOrderID) +1
FROM SalesLT.SalesOrderNumber1


DECLARE @DuteDate datetime2
set @DuteDate=convert(nvarchar,getdate()+7,102)

INSERT INTO SalesLT.SalesOrderHeader(SalesOrderID,OrderDate, DueDate,CustomerID,ShipMethod)
	     VALUES (@SalesOrderID,convert(nvarchar,getdate(),102), @DuteDate,'1','C0RGOTRANSPORT 5')

--
if @SalesOrderID = @SalesOrderID
    begin
			print 'Your SalesOrderID is : ' +convert(nvarchar(15),@SalesOrderID)
	end
else
   begin
			print 'Requested Failed'
	end

------------------檢視現存序列------------------

select *from SalesLT.SalesOrderNumber1 
ORDER BY SalesOrderID DESC

select *from SalesLT.SalesOrderHeader

------------------刪除多於序列-----------------

delete from SalesLT.SalesOrderHeader
where SalesOrderID >'71946'

DECLARE @i int = 1;
WHILE @i < 10
BEGIN
 PRINT @i;
END



'2. Write code to insert an order detail
The script to insert an order detail must enable users to specify a sales order ID, a product ID, a quantity,
and a unit price. It must then check to see if the specified sales order ID exists in the
SalesLT.SalesOrderHeader table. If it does, the code should insert the order details into the
SalesLT.SalesOrderDetail table (using default values or NULL for unspecified columns). If the sales order
ID does not exist in the SalesLT.SalesOrderHeader table, the code should print the message ‘The order
does not exist’. You can test for the existence of a record by using the EXISTS predicate.'

-------------------------插入數值--------------------------------------------
-- <測試1> --

INSERT INTO SalesLT.SalesOrderDetail(SalesOrderID,ProductID,OrderQty,UnitPrice)
	     VALUES ('71947','760','1','782.99')

-- <測試2> --

INSERT INTO SalesLT.SalesOrderDetail(SalesOrderID,ProductID,OrderQty,UnitPrice)
     VALUES ('0','760','1','782.99')

-----確認插入的數值中，SalesOrderID是否同樣存在於 SalesOrderHeader資料表--------

if (	select SalesOrderID from SalesLT.SalesOrderDetail
		except
		select SalesOrderID from SalesLT.SalesOrderHeader) is NULL
	begin 
   		Print 'The order requested has been insert'
	end
else
	begin
		Print 'The order does not exist'
	end



select * from SalesLT.SalesOrderDetail
select *from SalesLT.SalesOrderHeader 



'3. Write a WHILE loop to update bike prices
The loop should:
。 Execute only if the average list price of a product in the ‘Bikes’ parent category is less than the
market average. Note that the product categories in the Bikes parent category can be
determined from the SalesLT.vGetAllCategories view.
。 Update all products that are in the ‘Bikes’ parent category, increasing the list price by 10%.
。 Determine the new average and maximum selling price for products that are in the ‘Bikes’
parent category.
。 If the new maximum price is greater than or equal to the maximum acceptable price, exit the
loop; otherwise continue.'
/*
 the market average price for a bike is $2,000
 the maximum price any customer would be likely to pay for a bike is $5,000
 */

-- <1>提取出平均ListPrice小於市場價格($2,000)的商品
select ProductID,Name,AVG(ListPrice)as AvgListPrice,ProductCategoryID
from SalesLT.Product
group by ProductID,Name,ProductCategoryID
having AVG(ListPrice) < 2000

---<2>挑選出所有ProductCategoryID是 5 6 7 的商品

select *
from SalesLT.Product
where ProductCategoryID in
(select ProductCategoryID from SalesLT.vGetAllCategories
where ParentProductCategoryName like '%bike%')

---<3>合併兩程式(<1> + <2>)

select ProductID,Name,AVG(ListPrice)as AvgListPrice,ProductCategoryID
from SalesLT.Product
where ProductCategoryID in
(select ProductCategoryID from SalesLT.vGetAllCategories
where ParentProductCategoryName like '%bike%')
group by ProductID,Name,ProductCategoryID
having AVG(ListPrice) < 2000

--<4>建立暫存表簡化查詢步驟

create view SalesLT.vProductID1
as
select ProductID 
from

(select ProductID,Name,AVG(ListPrice)as AvgListPrice,ProductCategoryID
from SalesLT.Product
where ProductCategoryID in
(select ProductCategoryID from SalesLT.vGetAllCategories
where ParentProductCategoryName like '%bike%')
group by ProductID,Name,ProductCategoryID
having AVG(ListPrice) < 2000) As ID

select * from SalesLT.vProductID1

--<4>更新所有Bikes 的listprice 調漲10%

Update SalesLT.Product
set listprice = 1.1*listprice
 where ProductID in
(select * from SalesLT.vProductID)


/* DEBUG:檢視提取的數列*/

select *
 from SalesLT.Product
 where ProductID in
(select * from SalesLT.vProductID)

--<5> 迴圈：最大的ListPrice值大於或等於市場接受價格($5000)離開迴圈 否則繼續調漲

    declare @Listprice decimal(6,2)
	select @Listprice=MAX(ListPrice) FROM SalesLT.Product
	Print convert(nvarchar(100),@Listprice)

WHILE (@ListPrice<=5000)
	begin
		Update SalesLT.Product
			set listprice = 1.1*listprice
			where ProductID in
			(select * from SalesLT.vProductID)
		select @Listprice=MAX(ListPrice) FROM SalesLT.Product
        Print convert(nvarchar(100),@Listprice)

	end

	print 'Mission Complete';


/* DEBUG:測試邏輯迴圈*/
    declare @Listprice decimal(6,2)
	set @Listprice=1700.99
	Print convert(nvarchar(100),@Listprice)
WHILE (@ListPrice>=5000)
	begin
	Update SalesLT.vListPriceTest
			set listprice = 1.1*listprice
			where ProductID in
			(select * from SalesLT.vProductID)
		select @Listprice=MAX(ListPrice) FROM SalesLT.vListPriceTest
        Print convert(nvarchar(100),@Listprice)
	end

print 'Mission Complete'


select * from SalesLT.vListPriceTest




/*SELECT * from  SalesLT.Product
where ProductID in
			(
				select ProductID from
					(select ProductID,Name,AVG(ListPrice)as AvgListPrice,ProductCategoryID from SalesLT.Product
					 where ProductCategoryID in
					    (select ProductCategoryID from SalesLT.vGetAllCategories
						where ParentProductCategoryName like '%bike%')
						group by ProductID,Name,ProductCategoryID
						having AVG(ListPrice) < 2000)as ID
					)
SELECT listprice from  SalesLT.Product
where ProductID='749'

*/
