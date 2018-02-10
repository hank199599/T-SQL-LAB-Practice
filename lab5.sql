'1. Retrieve the name and approximate weight of each product
Write a query to return the product ID of each product, together with the product name formatted as
upper case and a column named ApproxWeight with the weight of each product rounded to the nearest
whole unit.'

select convert(nvarchar(4),ProductID)+' :  '+convert(nvarchar(40),Name) AS UpperCase, isnull(round(Weight,0,1),0)as ApproxWeight
from SalesLT.Product


'2. Retrieve the year and month in which products were first sold
Extend your query to include columns named SellStartYear and SellStartMonth containing the year and
month in which Adventure Works started selling each product. The month should be displayed as the
month name (for example, ¡¥January¡¦).'

select year(SellStartDate) SellStartYear,CHOOSE(MONTH(SellStartDate),'January','Faburary', 'March','April','May','June','July','August','September','October','Novenber','Decenber') SellStartMonth
, convert(nvarchar(4),ProductID)+' :  '+convert(nvarchar(40),Name) AS UpperCase, isnull(round(Weight,0,1),0)as ApproxWeight
from SalesLT.Product

'3. Extract product types from product numbers
Extend your query to include a column named ProductType that contains the leftmost two characters
from the product number.'

select year(SellStartDate) SellStartYear,CHOOSE(MONTH(SellStartDate),'January','Faburary', 'March','April','May','June','July','August','September','October','Novenber','Decenber') SellStartMonth
, convert(nvarchar(4),ProductID)+' :  '+convert(nvarchar(40),Name) AS UpperCase, isnull(round(Weight,0,1),0)as ApproxWeight,left(ProductNumber,2)ProductType
from SalesLT.Product

'4. Retrieve only products with a numeric size
Extend your query to filter the product returned so that only products with a numeric size are included.'

select year(SellStartDate) SellStartYear,CHOOSE(MONTH(SellStartDate),'January','Faburary', 'March','April','May','June','July','August','September','October','Novenber','Decenber') SellStartMonth
, convert(nvarchar(4),ProductID)+' :  '+convert(nvarchar(40),Name) AS UpperCase, isnull(round(Weight,0,1),0)as ApproxWeight,left(ProductNumber,2)ProductType
from SalesLT.Product
where ISNUMERIC(Size) = 1


'5. Retrieve companies ranked by sales totals
Write a query that returns a list of company names with a ranking of their place in a list of highest
TotalDue values from the SalesOrderHeader table.'

select  Saleslt.Customer.CompanyName,RANK() OVER(ORDER BY Saleslt.SalesOrderHeader.TotalDue DESC) AS RankByTotalDue,Saleslt.SalesOrderHeader.TotalDue
from Saleslt.Customer
left join Saleslt.SalesOrderHeader
on Saleslt.Customer.CustomerID=Saleslt.SalesOrderHeader.CustomerID

select* from Saleslt.Customer
select* from Saleslt.SalesOrderHeader

'6. Retrieve total sales by product
Write a query to retrieve a list of the product names and the total revenue calculated as the sum of the
LineTotal from the SalesLT.SalesOrderDetail table, with the results sorted in descending order of total
revenue.'

select Saleslt.Product.Name,isnull(SUM(SalesLT.SalesOrderDetail.LineTotal),0) TotalRevenue
from Saleslt.Product
left join SalesLT.SalesOrderDetail
on Saleslt.Product.ProductID=SalesLT.SalesOrderDetail.ProductID
Group by Saleslt.Product.Name
Order By TotalRevenue Desc

'7. Filter the product sales list to include only products that cost over $1,000
Modify the previous query to include sales totals for products that have a list price of more than $1000.'

select Saleslt.Product.Name,SUM(SalesLT.SalesOrderDetail.LineTotal)TotalRevenue, SalesLT.SalesOrderDetail.UnitPrice as Cost
from Saleslt.Product
left join SalesLT.SalesOrderDetail
on Saleslt.Product.ProductID=SalesLT.SalesOrderDetail.ProductID
Group by Saleslt.Product.Name,SalesLT.SalesOrderDetail.UnitPrice
HAVING SUM(SalesLT.SalesOrderDetail.LineTotal)>1000
Order By TotalRevenue Desc


select* from Saleslt.Product
select* from SalesLT.SalesOrderDetail


'8. Filter the product sales groups to include only total sales over $20,000
Modify the previous query to only include only product groups with a total sales value greater than
$20,000.'

select Saleslt.Product.Name,SUM(SalesLT.SalesOrderDetail.LineTotal)TotalRevenue, SalesLT.SalesOrderDetail.UnitPrice as Cost
from Saleslt.Product
left join SalesLT.SalesOrderDetail
on Saleslt.Product.ProductID=SalesLT.SalesOrderDetail.ProductID
Group by Saleslt.Product.Name,SalesLT.SalesOrderDetail.UnitPrice
HAVING SUM(SalesLT.SalesOrderDetail.LineTotal)>20000
Order By TotalRevenue Desc
