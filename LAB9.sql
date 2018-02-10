'1. Insert a product
Adventure Works has started selling the following new product. Insert it into the SalesLT.Product table,
using default or NULL values for unspecified columns: '--允許將明確的值插入資料表的識別欄位中。SET IDENTITY_INSERT SalesLT.Product ON ;GO--插入數值insert into  SalesLT.Product (ProductID,Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)values('1000', 'LED Lights', 'LT-L123','2.56' ,'12.99', '37','2018-02-10 00:00:00.000') --檢視插入數值select*from SalesLT.Product'2. Insert a new category with two products
Adventure Works is adding a product category for ‘Bells and Horns’ to its catalog. The parent category for
the new category is 4 (Accessories). This new category includes the following two new products: '

--允許將明確的值插入資料表的識別欄位中。SET IDENTITY_INSERT SalesLT.Product ON ;

--插入數據到 SalesLT.Product

INSERT INTO SalesLT.Product(ProductID,Name ,ProductNumber, StandardCost ,ListPrice ,ProductCategoryID ,SellStartDate )
VALUES
('1001','Bicycle Bell','BB-RING','2.47' ,'4.99','42','2018-02-10 00:00:00.000'),
('1002','Bicycle Horn','BB-PARP','1.29 ','3.75','43','2018-02-10 00:00:00.000' );

--檢視插入數值select*from SalesLT.Product

--拒絕將明確的值插入資料表的識別欄位中。
SET IDENTITY_INSERT SalesLT.Product Off ;

===========================================================================================
--允許將明確的值插入資料表的識別欄位中。SET IDENTITY_INSERT SalesLT.ProductCategory ON ;

--插入數據到 SalesLT.ProductCategory

INSERT INTO SalesLT.ProductCategory(ProductCategoryID,ParentProductCategoryID,Name)
VALUES
('42','4','Bicycle Bell'),
('43','4','Bicycle Horn');

--檢視插入數值select*from  SalesLT.ProductCategory

--拒絕將明確的值插入資料表的識別欄位中。
SET IDENTITY_INSERT SalesLT.ProductCategory Off ;


'3. Update product prices
The sales manager at Adventure Works has mandated a 10% price increase for all products in the Bells
and Hor ns category. Update the rows in the SalesLT.Product table for these products to increase their
price by 10%.'

Update SalesLT.Product
SET ListPrice=1.1*ListPrice
where name like'%Horn%'

Update SalesLT.Product
SET ListPrice=1.1*ListPrice
where name like'%Bell%'


'4. Discontinue products
The new LED lights you inserted in the previous challenge are to replace all previous light products.
Update the SalesLT.Product table to set the DiscontinuedDate to today’s date for all products in the
Lights category (Product Category ID 37) other than the LED Lights product you inserted previously. '

select * from SalesLT.Product
where ProductCategoryID='37'

Update SalesLT.Product
SET DiscontinuedDate=GETDATE ()
where ProductCategoryID='37'


'1. Delete a product category and its products
Delete the records foe the Bells and Horns category and its products. You must ensure that you delete
the records from the tables in the correct order to avoid a foreign-key constraint violation. '

Delete from SalesLT.Product
where name like'%Horn%'

Delete from SalesLT.Product
where name like'%Bell%'

select * from SalesLT.Product
where name like'%Bell%'
union
select * from SalesLT.Product
where name like'%Horn%'


Delete from SalesLT.ProductCategory
where name like'%Horn%'

Delete from SalesLT.ProductCategory
where name like'%Bell%'

select * from SalesLT.ProductCategory
where name like'%Bell%'
union
select * from SalesLT.ProductCategory
where name like'%Horn%'