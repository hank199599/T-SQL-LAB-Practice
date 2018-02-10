'1. Retrieve product model descriptions
Retrieve the product ID, product name, product model name, and product model summary for each
product from the SalesLT.Product table and the SalesLT.vProductModelCatalogDescription view.'




select ProductID,Name from SalesLT.Product

select ProductModelID,Name,Summary from SalesLT.vProductModelCatalogDescription

select*from SalesLT.Product
select*from SalesLT.vProductModelCatalogDescription



'2. Create a table of distinct colors
Tip: Review the documentation for Variables in Transact-SQL Language Reference.
Create a table variable and populate it with a list of distinct colors from the SalesLT.Product table. Then
use the table variable to filter a query that returns the product ID, name, and color from the
SalesLT.Product table so that only products with a color listed in the table variable are returned.'

select SalesLT.Product.ProductID,SalesLT.Product.Name,SalesLT.Product.Color
from SalesLT.Product
join (
select Color  from SalesLT.Product
group by color) as colorfilter
on SalesLT.Product.Color= colorfilter.Color


'3. Retrieve product parent categories
The AdventureWorksLT database includes a table-valued function named dbo.ufnGetAllCategories,
which returns a table of product categories (for example ‘Road Bikes’) and parent categories (for
example ‘Bikes’). Write a query that uses this function to return a list of all products including their
parent category and category.'

------------------------不透過函式直接提取----------------------------------
select PRODUCT.NAME as Product_Categories,Parent.NAME as Parent_Categories
from SalesLT.ProductCategory AS PRODUCT
join (select ProductCategoryID,Name from SalesLT.ProductCategory) as Parent
on PRODUCT.ParentProductCategoryID =Parent.ProductCategoryID
-----------------------------------------------------------------------------


select*from SalesLT.ProductCategory

----------------------------透過函式提取-------------------------------------

無解 無法提取出數據

-----------------------------------------------------------------------------

select* from dbo.ufnGetAllCategories(1,2,3,4)

'1. Retrieve sales revenue by customer and contact
Retrieve a list of customers in the format Company (Contact Name) together with the total revenue for
that customer. Use a derived table or a common table expression to retrieve the details for each sales
order, and then query the derived table or CTE to aggregate and group the data.'-----------------derived table-----------------------Contact Name total revenueselect SalesLT.Customer.CustomerID,SalesLT.Customer.CompanyName,Sales.TotalRevenue As TotalRevenuefrom SalesLT.Customerjoin(select  SUM (SalesLT.SalesOrderDetail.LineTotal)AS TotalRevenue,SalesLT.SalesOrderHeader.CustomerIDFROM SalesLT.SalesOrderDetailjoin SalesLT.SalesOrderHeaderon SalesLT.SalesOrderDetail.SalesOrderID= SalesLT.SalesOrderHeader.SalesOrderIDGroup by SalesLT.SalesOrderHeader.CustomerID) as Saleson SalesLT.Customer.CustomerID=Sales.CustomerID-------------common table expression-----------------select SalesLT.Customer.CustomerID,SalesLT.Customer.CompanyName,SUM(SalesLT.SalesOrderDetail.LineTotal) As TotalRevenuefrom SalesLT.Customerjoin SalesLT.SalesOrderHeaderon SalesLT.Customer.CustomerID=SalesLT.SalesOrderHeader.CustomerIDJOIN SalesLT.SalesOrderDetailon SalesLT.SalesOrderDetail.SalesOrderID= SalesLT.SalesOrderHeader.SalesOrderIDGroup by SalesLT.Customer.CustomerID,SalesLT.Customer.CompanyName---------------CTE to aggregate and group the data---------------------WITH CustomerDetails (CustomerID,CompanyName,TotalRevenue)As(select SalesLT.Customer.CustomerID,SalesLT.Customer.CompanyName,SUM(SalesLT.SalesOrderDetail.LineTotal) As TotalRevenuefrom SalesLT.Customerjoin SalesLT.SalesOrderHeaderon SalesLT.Customer.CustomerID=SalesLT.SalesOrderHeader.CustomerIDJOIN SalesLT.SalesOrderDetailon SalesLT.SalesOrderDetail.SalesOrderID= SalesLT.SalesOrderHeader.SalesOrderIDGroup by SalesLT.Customer.CustomerID,SalesLT.Customer.CompanyName)SELECT * FROM CustomerDetailsSELECT* FROM SalesLT.Customer          CustomerID CompanyNameSELECT* FROM SalesLT.SalesOrderDetail  SalesOrderID LineTotalSELECT* FROM SalesLT.SalesOrderHeader  SalesOrderID CustomerID