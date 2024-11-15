SELECT * FROM Products;

SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT * FROM OrderDetails;


SELECT * FROM ProductTypes;


SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING SUM(od.Quantity) > 0;


SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE DATEPART(WEEKDAY, o.OrderDate) BETWEEN 1 AND 7
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT DATEPART(WEEKDAY, o.OrderDate)) = 7;


SELECT TOP 1 c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalOrders DESC;


SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantityOrdered DESC;


SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Widget';



SELECT c.CustomerName,
       SUM(CASE WHEN p.ProductType = 'Widget' THEN od.Quantity * p.Price ELSE 0 END) AS TotalWidgetCost,
       SUM(CASE WHEN p.ProductType = 'Gadget' THEN od.Quantity * p.Price ELSE 0 END) AS TotalGadgetCost
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType IN ('Widget', 'Gadget')
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(CASE WHEN p.ProductType = 'Widget' THEN od.Quantity ELSE 0 END) > 0
   AND SUM(CASE WHEN p.ProductType = 'Gadget' THEN od.Quantity ELSE 0 END) > 0;



   SELECT c.CustomerName, SUM(od.Quantity * p.Price) AS TotalGadgetCost
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Gadget'
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(od.Quantity * p.Price) > 0;


SELECT c.CustomerName, SUM(od.Quantity * p.Price) AS TotalDoohickeyCost
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Doohickey'
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(od.Quantity * p.Price) > 0;



SELECT c.CustomerName,
       SUM(CASE WHEN p.ProductType = 'Widget' THEN od.Quantity ELSE 0 END) AS TotalWidgets,
       SUM(CASE WHEN p.ProductType = 'Gadget' THEN od.Quantity ELSE 0 END) AS TotalGadgets,
       SUM(od.Quantity * p.Price) AS TotalCost
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType IN ('Widget', 'Gadget')
GROUP BY c.CustomerID, c.CustomerName;
