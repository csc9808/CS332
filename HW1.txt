-- Seong Chan Cho

-- 1 
use ap
GO

-- 2 (need to double check on order by function)
SELECT VendorContactFName
	, VendorContactLName
	, VendorName
	, VendorCity
	, VendorState
from Vendors
order by VendorState, VendorCity, VendorContactFName, VendorContactLName DESC
Go

-- 3 
SELECT VendorContactLName + ','+ VendorContactFName AS [FullName]
from Vendors
WHERE VendorState = 'OH'
ORDER BY VendorContactLName,
		VendorContactFName
GO


-- 4 
SELECT InvoiceTotal, InvoiceTotal / 10 AS [25%]
	,InvoiceTotal * 1.1 AS [Plus 25%]
from Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 1000 
ORDER BY InvoiceTotal  DESC
GO

--5 a first possible answer
SELECT VendorContactLName + ',' + VendorContactFName AS [FullName]
from Vendors
WHERE VendorContactLName LIKE '[A,D,E,L]%'
ORDER BY VendorContactLName, VendorContactFName
GO

--5 b Second Possible Answer
SELECT VendorContactLName + ',' + VendorContactFName AS [FullName]
from Vendors
WHERE VendorContactLName LIKE '[A-L]%' AND VendorContactLName NOT LIKE '[B-C,F-K]%'
ORDER BY VendorContactLName, VendorContactFName
GO

--6
SELECT * from Invoices
WHERE  PaymentDate IS NULL AND PaymentTotal != 0

--7
SELECT * from Vendors
WHERE DefaultTermsID = 3

--8 
SELECT * from Vendors
WHERE DefaultTermsID = 3 AND DefaultAccountNo >= 540 

--9
SELECT * from Vendors
WHERE VendorName LIKE '%Compan%'

--10
SELECT VendorState  
	,SUBSTRING(VendorPhone,1,5)
from Vendors

--11
SELECT VendorState  
	,SUBSTRING(VendorPhone,1,5)
from Vendors
WHERE VendorPhone IS NOT NULL


-- 12 
use pubs
GO


-- 13
SELECT top 5 title
	, ytd_sales
from titles
ORDER BY ytd_sales DESC
GO

--14
SELECT title
	, ytd_sales / price AS [Sold]
from titles

--15
SELECT top 1 title
	, ytd_sales / price AS [Sold]
from titles
ORDER BY Sold DESC

--16
-- Because The Variable (Column name) is not in bracket but in double quotation. 