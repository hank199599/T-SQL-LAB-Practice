select CONVERT(varchar(5),CustomerID) + ' : ' + CompanyName as Campany_Details
From SalesLT.Customer;

-------------------------
DECLARE @date date= '2015.01.31'; 
select convert(varchar(7),SalesOrderNumber)+' ('+convert(varchar(5),RevisionNumber)+')',
       convert(date,OrderDate) As ConvertedDate
From  SalesLT.SalesOrderHeader


select *
From SalesLT.Address;

select DISTINCT City,StateProvince
From SalesLT.Address;

select *
From SalesLT.product;

select top 100 weight,name
From SalesLT.product
order by weight desc;

SELECT weight,name FROM SalesLT.product ORDER BY weight desc OFFSET 10 ROWS FETCH NEXT 90 ROWS ONLY

select weight,name
From SalesLT.product
order by weight desc

select name, weight
From SalesLT.product;

---------------------------------------
select *
From SalesLT.product

select name, color, size
From SalesLT.product
WHERE ProductModelID = 1;

select productNumber, name, color, size
From SalesLT.product
WHERE color in ('black','red','white') AND size in ('S', 'M')

select productNumber, name,listprice
From SalesLT.product
WHERE productNumber LIKE 'BK-_[0-9][0-9]_-[0-9][0-9]' AND productNumber in ('M','S','B','T','Y')

select productNumber, name,listprice
From SalesLT.product
WHERE productNumber LIKE 'BK%' ;

select productNumber, name,listprice
From SalesLT.product
WHERE productNumber LIKE 'BK%' AND productNumber LIKE 'BK-T%' OR productNumber LIKE 'BK-M%' AND productNumber LIKE '%-[0-9][0-9]' ;


