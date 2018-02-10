'1. Retrieve products whose list price is higher than the average unit price
Retrieve the product ID, name, and list price for each product where the list price is higher than the
average unit price for all products that have been sold.'

select Name,ProductID,ListPrice
from SalesLT.Product
WHERE ListPrice>
(select AVG(UnitPrice) from SalesLT.SalesOrderDetail)

'2. Retrieve Products with a list price of $100 or more that have been sold for less than
$100
Retrieve the product ID, name, and list price for each product where the list price is $100 or more, and
the product has been sold for less than $100.'

select Name,ProductID,ListPrice
from SalesLT.Product
WHERE ProductID IN
(SELECT ProductID FROM SalesLT.SalesOrderDetail
WHERE UnitPrice<100)
INTERSECT
select Name,ProductID,ListPrice
from SalesLT.Product
WHERE ListPrice > 100

'3. Retrieve the cost, list price, and average selling price for each product
Retrieve the product ID, name, cost, and list price for each product along with the average unit price for
which that product has been sold.'

select SalesLT.SalesOrderDetail.ProductID,SalesLT.Product.Name,SalesLT.Product.StandardCost,SalesLT.Product.ListPrice,AVG(SalesLT.SalesOrderDetail.UnitPrice) AvgUnitPrice
from SalesLT.Product
join SalesLT.SalesOrderDetail
on SalesLT.Product.ProductID=SalesLT.SalesOrderDetail.ProductID
Group by SalesLT.SalesOrderDetail.ProductID,SalesLT.Product.Name,SalesLT.Product.StandardCost,SalesLT.Product.ListPrice


'4. Retrieve products that have an average selling price that is lower than the cost
Filter your previous query to include only products where the cost price is higher than the average selling price.'

select SalesLT.SalesOrderDetail.ProductID,SalesLT.Product.Name,SalesLT.Product.StandardCost As CostPrice,SalesLT.Product.ListPrice,AVG(SalesLT.SalesOrderDetail.UnitPrice) AvgUnitPrice
from SalesLT.Product
join SalesLT.SalesOrderDetail
on SalesLT.Product.ProductID=SalesLT.SalesOrderDetail.ProductID
where  SalesLT.Product.StandardCost > (select AVG(UnitPrice) from SalesLT.SalesOrderDetail)
Group by SalesLT.SalesOrderDetail.ProductID,SalesLT.Product.Name,SalesLT.Product.StandardCost,SalesLT.Product.ListPrice

'1. Retrieve customer information for all sales orders
Retrieve the sales order ID, customer ID, first name, last name, and total due for all sales orders from the SalesLT.SalesOrderHeader table and the dbo.ufnGetCustomerInformation function.'

select SalesLT.SalesOrderHeader.SalesOrderID,SalesLT.SalesOrderHeader.CustomerID, SalesLT.Customer.firstname, SalesLT.Customer.lastname, SalesLT.SalesOrderHeader.totaldue
from SalesLT.SalesOrderHeader
CROSS APPLY dbo.ufnGetCustomerInformation (SalesLT.SalesOrderHeader.CustomerID) AS DBO
JOIN SalesLT.Customer
ON SalesLT.SalesOrderHeader.CustomerID=DBO.CustomerID
WHERE SalesLT.Customer.CustomerID=SalesLT.SalesOrderHeader.CustomerID

'2. Retrieve customer address information
Retrieve the customer ID, first name, last name, address line 1 and city for all customers from the SalesLT.Address and SalesLT.CustomerAddress tables, and the dbo.ufnGetCustomerInformation function.'

select  SalesLT.CustomerAddress.CustomerID, SalesLT.Customer.firstname, SalesLT.Customer.lastname,SalesLT.Address.addressline1, SalesLT.Address.city
from SalesLT.CustomerAddress
CROSS APPLY dbo.ufnGetCustomerInformation (SalesLT.CustomerAddress.CustomerID) AS DBO
join SalesLT.Address
ON SalesLT.Address.AddressID=SalesLT.CustomerAddress.AddressID
JOIN SalesLT.Customer
ON  SalesLT.CustomerAddress.CustomerID=SalesLT.Customer.CustomerID
WHERE   SalesLT.CustomerAddress.CustomerID=DBO.CustomerID
