CREATE DATABASE Customers_Orders_Products; 

CREATE TABLE Customers(
CustomerID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(100)
);

---------SELECT * FROM Customers;

INSERT INTO Customers (CustomerID, Name, Email)
VALUES
  (1, 'John Doe', 'johndoe@example.com'),
  (2, 'Jane Smith', 'janesmith@example.com'),
  (3, 'Robert Johnson', 'robertjohnson@example.com'),
  (4, 'Emily Brown', 'emilybrown@example.com'),
  (5, 'Michael Davis', 'michaeldavis@example.com'),
  (6, 'Sarah Wilson', 'sarahwilson@example.com'),
  (7, 'David Thompson', 'davidthompson@example.com'),
  (8, 'Jessica Lee', 'jessicalee@example.com'),
  (9, 'William Turner', 'williamturner@example.com'),
  (10, 'Olivia Martinez', 'oliviamartinez@example.com');

CREATE TABLE Orders(
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductName VARCHAR(50),
OrderDate DATE,
Quantity INT
);

-----SELECT * FROM Orders;

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity)
VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1);

  CREATE TABLE Products 
(
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);


INSERT INTO Products (ProductID, ProductName, Price)
VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99);

SELECT * FROM Products;

  ---Task1---

  --1. Write a query to retrieve all records from the Customers table..
  
  SELECT * From Customers;

  --2. Write a query to retrieve the names and email addresses of customers whose names start with 'J'.

  SELECT Name, Email
  From Customers
  Where Name like 'J%';

  --3. Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders

  SELECT OrderID, ProductName, Quantity
  FROM Orders;

  --4. Write a query to calculate the total quantity of products ordered.

  SELECT SUM(Quantity) AS Total_Quantity
  FROM Orders;

  

  --5. Write a query to retrieve the names of customers who have placed an order.

  SELECT A.Name, B.OrderID
  From Customers As A
  INNER JOIN 
  Orders As B
  ON A.CustomerID = B.CustomerID;

  --6. Write a query to retrieve the products with a price greater than $10.00.

  SELECT ProductName, Price
  From Products
  WHERE Price > 10.00;


  --7. Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'.

  SELECT A.Name, B.OrderDate
  From Customers As A
  INNER JOIN 
  Orders As B
  ON A.CustomerID = B.CustomerID
  WHERE B.OrderDate >= '2023-07-05';

  ---8. Write a query to calculate the average price of all products.

  SELECT AVG(Price) AS Average_Price
  From Products;

---9. Write a query to retrieve the customer names along with the total quantity of products they have ordered

SELECT A.NAME, B.Quantity, B.ProductName
From Customers AS A
INNER JOIN
Orders AS B
ON A.CustomerID = B.CustomerID;

--10.	Write a query to retrieve the products that have not been ordered.

SELECT A.ProductName, A.ProductID
From Products AS A
INNER JOIN 
Orders AS B
ON A.ProductName = B.ProductName
WHERE B.ProductName IS NULL;



---TASK 2---

----1.	Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders.

SELECT A.Name, B.Quantity
From Customers AS A
INNER JOIN 
Orders AS B
ON A.CustomerID = B.CustomerID
ORDER BY B.Quantity DESC;

-----2.	Write a query to calculate the average price of products for each product category.

SELECT AVG(Price) AS Average_Price
FROM Products
GROUP BY ProductName;

----3.	Write a query to retrieve the customers who have not placed any orders

SELECT A.Name, A.CustomerID
From Customers AS A
INNER JOIN 
Orders AS B
ON A.CustomerID = B.CustomerID
WHERE B.CustomerID IS NULL;

----4.	Write a query to retrieve the order details (OrderID, ProductName, Quantity) for orders placed by customers whose names start with 'M'.

SELECT A.Name, B.OrderID, B.ProductName, B.Quantity
From Customers AS A
INNER JOIN 
Orders AS B
ON A.CustomerID = B.CustomerID
WHERE A.Name LIKE 'M%';

---5.	Write a query to calculate the total revenue generated from all orders

SELECT SUM(A.Quantity * B.Price) AS Total_Revenue
From Orders AS A
JOIN Products AS B
ON A.ProductName = B.ProductName;

----6.	Write a query to retrieve the customer names along with the total revenue generated from their orders.

SELECT A.Name, SUM(C.Quantity * B.Price) AS Revenue
From Customers AS A
JOIN Orders AS C
ON A.CustomerID = C.CustomerID
JOIN Products AS B
ON C.ProductName = B.ProductName
Group BY A.Name;


----7.	Write a query to retrieve the customers who have placed at least one order for each product category.

SELECT A.Name, C.Quantity, B.ProductName
From Customers AS A
JOIN Orders AS C
ON A.CustomerID = C.CustomerID
JOIN Products AS B
ON C.ProductName = B.ProductName

---8.	Write a query to retrieve the customers who have placed orders on consecutive days.

SELECT DISTINCT c.CustomerID, c.Name
FROM Customers c
JOIN Orders o1 ON c.CustomerID = o1.CustomerID
JOIN Orders o2 ON c.CustomerID = o2.CustomerID
WHERE o1.OrderDate = o2.OrderDate - INTERVAL 1 DAY
ORDER BY c.CustomerID;


---9.	Write a query to retrieve the top 3 products with the highest average quantity ordered.

SELECT A.ProductName, AVG(B.Quantity) AS AverageQuantity
FROM Orders B
JOIN Products A 
ON A.ProductName = A.ProductName
GROUP BY A.ProductName
ORDER BY AverageQuantity DESC
LIMIT 3;


  ---Task3---

  ----1.	Write a query to retrieve the customers who have placed orders for all products.

SELECT C.CustomerID, C.Name
FROM Customers C
JOIN Orders O 
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name
HAVING COUNT(DISTINCT O.ProductName) = (SELECT COUNT(*) FROM Products);





