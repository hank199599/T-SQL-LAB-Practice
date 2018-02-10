 select SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType ,SalesLT.Address.AddressLine1+isnull(AddressLine2,' ')+','+City+','+StateProvince+','+CountryRegion+' '+PostalCode as AddressLine,
SalesLT.SalesOrderHeader. SalesOrderID, SalesLT.SalesOrderHeader.TotalDue
 from SalesLT.Customer
JOIN SalesLT.SalesOrderHeader
 on SalesLT.Customer.Namestyle=SalesLT.SalesOrderHeader.OnlineOrderFlag
JOIN  SalesLT.CustomerAddress
on  SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID
JOIN  SalesLT.Address
on  SalesLT.Address.AddressID=SalesLT.CustomerAddress.AddressID
where SalesLT.CustomerAddress.AddressType like 'Main Office'

---------------------------------------------------------------
'1.The sales manager wants a list of all customer companies and their contacts (first name and last name),
showing the sales order ID and total due for each order they have placed. Customers who have not
placed any orders should be included at the bottom of the list with NULL values for the order ID and
total due.'
select SalesLT.Customer.CustomerID, SalesLT.Customer.FirstName+' '+LastName as CustomerName,SalesLT.Customer.CompanyName ,SalesLT.SalesOrderHeader.SalesOrderID,SalesLT.SalesOrderHeader.TotalDue
from SalesLT.Customer
LEFT join SalesLT.SalesOrderHeader
on SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
order by SalesLT.SalesOrderHeader.SalesOrderID desc

------------------------------------------------------------------
'2.A sales employee has noticed that Adventure Works does not have address information for all
customers. You must write a query that returns a list of customer IDs, company names, contact names
(first name and last name), and phone numbers for customers with no address stored in the database.
'
select SalesLT.Customer.CustomerID,SalesLT.Customer.CompanyName,SalesLT.Customer.FirstName+' '+LastName as CustomerName,SalesLT.Customer.Phone
from SalesLT.Customer
left JOIN SalesLT.CustomerAddress
on  SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID
where SalesLT.CustomerAddress.AddressID is null
---------------------------------------------------------------------
'3.Some customers have never placed orders, and some products have never been ordered. Create a query
that returns a column of customer IDs for customers who have never placed an order, and a column of
product IDs for products that have never been ordered. Each row with a customer ID should have a
NULL product ID (because the customer has never ordered a product) and each row with a product ID
should have a NULL customer ID (because the product has never been ordered by a customer).'

select SalesLT.Product.ProductID,SalesLT.SalesOrderHeader.CustomerID          
from SalesLT.Product
full join SalesLT.SalesOrderHeader
on SalesLT.Product.DiscontinuedDate=SalesLT.SalesOrderHeader.CreditCardApprovalCode


select*            from SalesLT.Product
select*            from SalesLT.SalesOrderHeader
select*            from SalesLT.Customer 

select AddressLine1+isnull(AddressLine2,' ')+','+City+','+StateProvince+','+CountryRegion+' '+PostalCode as  MainOfficeaddress from SalesLT.Address

select*            from SalesLT.Address
select*            from SalesLT.CustomerAddress
select*            from SalesLT.SalesOrderHeader
 
 
 
 select CompanyName from SalesLT.Customer
 select SalesOrderID,TotalDue from SalesLT.SalesOrderHeader