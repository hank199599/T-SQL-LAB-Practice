/*1. Throw an error for non-existent orders
You are currently using the following code to delete order data:
DECLARE @SalesOrderID int = <the_order_ID_to_delete>
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
This code always succeeds, even when the specified order does not exist. Modify the code to check for
the existence of the specified order ID before attempting to delete it. If the order does not exist, your
code should throw an error. Otherwise, it should go ahead and delete the order data.*/

DECLARE @SalesOrderID int = 71782 
WHILE (@SalesOrderID<=71783)
BEGIN
if  @SalesOrderID =(SELECT @SalesOrderID INTERSECT SELECT SalesOrderID FROM SalesLT.SalesOrderDetail) 
BEGIN
print 'Specified ID found : '+CONVERT(NVARCHAR(30),@SalesOrderID)
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
SET @SalesOrderID=@SalesOrderID+1
END
else
begin
	THROW 50001, 'The Specified ID was not found - no products have been updated', 0;
end
END
	print 'Mission Complete'

/*2. Handle errors
Your code now throws an error if the specified order does not exist. You must now refine your code to
catch this (or any other) error and print the error message to the user interface using the PRINT
command.*/

DECLARE @SalesOrderID int = 71782 
WHILE (@SalesOrderID<=71784)
BEGIN
if  @SalesOrderID =(SELECT @SalesOrderID INTERSECT SELECT SalesOrderID FROM SalesLT.SalesOrderDetail) 
BEGIN
print 'Specified ID found : '+CONVERT(NVARCHAR(30),@SalesOrderID)
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
SET @SalesOrderID=@SalesOrderID+1
END
else
begin
    PRINT 'The Specified ID was not found - no products have been updated';
	PRINT ERROR_MESSAGE();
	SET @SalesOrderID=@SalesOrderID+1
end
END
    print '****************'
	print 'Mission Complete'


/*3. Implement a transaction
Enhance the code you created in the previous challenge so that the two DELETE statements are treated
as a single transactional unit of work. In the error handler, modify the code so that if a transaction is in
process, it is rolled back and the error is re-thrown to the client application. If not transaction is in
process the error handler should continue to simply print the error message.
To test your transaction, add a THROW statement between the two DELETE statements to simulate an
unexpected error. When testing with a valid, existing order ID, the error should be re-thrown by the
error handler and no rows should be deleted from either table. */


DECLARE @SalesOrderID int = 71782 
WHILE (@SalesOrderID<=71784)
BEGIN
if  @SalesOrderID =(SELECT @SalesOrderID INTERSECT SELECT SalesOrderID FROM SalesLT.SalesOrderDetail) 
BEGIN
print 'Specified ID found : '+CONVERT(NVARCHAR(30),@SalesOrderID)
DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;
THROW
DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
SET @SalesOrderID=@SalesOrderID+1
END
else
begin
    PRINT 'The Specified ID was not found - no products have been updated';
	PRINT ERROR_MESSAGE();
	SET @SalesOrderID=@SalesOrderID+1
end
END
    print '****************'
	print 'Mission Complete'
