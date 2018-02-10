'1.Write a query that retrieves the company name, first line of the street address, city, and a column
named AddressType with the value ．Billing・ for customers where the address type in the
SalesLT.CustomerAddress table is ．Main Office・.'

SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Main Office'


'2. Write a similar query that retrieves the company name, first line of the street address, city, and a
column named AddressType with the value ．Shipping・ for customers where the address type in the
SalesLT.CustomerAddress table is ．Shipping・.'

SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Shipping'



'3. Combine the results returned by the two queries to create a list of all customer addresses that is sorted
by company name and then address type.'

SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Main Office'
union
SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Shipping'


'1. Retrieve customers with only a main office address
Write a query that returns the company name of each company that appears in a table of customers
with a ．Main Office・ address, but not in a table of customers with a ．Shipping・ address.'

SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
except
SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Shipping'



'2. Retrieve only customers with both a main office address and a shipping address
Write a query that returns the company name of each company that appears in a table of customers
with a ．Main Office・ address, and also in a table of customers with a ．Shipping・ address.'
SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Main Office'
intersect
SELECT SalesLT.Customer.CompanyName,SalesLT.CustomerAddress.AddressType as Billing,SalesLT.Address.AddressLine1 as StressAddress,SalesLT.Address.City
from SalesLT.Customer 
left join SalesLT.CustomerAddress
on SalesLT.Customer.CustomerID=SalesLT.CustomerAddress.CustomerID

join SalesLT.Address
on SalesLT.CustomerAddress.AddressID=SalesLT.Address.AddressID
where AddressType like 'Shipping'