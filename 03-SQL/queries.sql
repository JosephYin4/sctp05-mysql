--SELECT all columns from a table
SELECT * FROM employees;

--To show specific columns

SELECT firstName, lastName, email FROM employees;

SELECT checkNumber, amount * 0.09 from payments;

SELECT orderNumber AS "Order Number" from order;

SELECT * FROM employees WHERE officeCode = 1;

SELECT * from employees WHERE reportsTo = 1143;

SELECT lastName, firstName, email from employees WHERE officeCode = 1;
SELECT lastName, firstName, email, officeCode from employees WHERE officeCode = 1;

SELECT customerName, phone, country FROM customers WHERE country = "France";

SELECT * FROM customers WHERE creditLimit > 50000 and country = "USA";

SELECT * FROM customers WHERE country = "USA" or country = "France";

SELECT * FROM customers WHERE (country = "USA" or country = "France") and creditLimit > 50000;

-- (%sales) or (sales%) or (%sales%)
SELECT * FROM employees WHERE jobTitle LIKE "sales%";

-- join two tables: employees and offices, to find out which country and state
-- they are stationed
SELECT * FROM employees JOIN offices
 ON employees.officeCode = offices.officeCode;

 SELECT firstName,lastName, country, city FROM employees JOIN offices
ON employees.officeCode = offices.officeCode
WHERE country = "USA";

--Order of precedence
1. JOIN
2. WHERE
3. SELECT

SELECT customerName, lastName, firstName FROM customers JOIN employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber;

--Join 2 tables together
SELECT supervised_employees.firstName AS "Employee firstName", supervisor.firstName AS "Supervisor firstName"
FROM employees AS supervised_employees JOIN employees AS supervisor
ON supervised_employees.reportsTo = supervisor.employeeNumber;

--Join 3 tables together
SELECT * FROM customers JOIN employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber
 JOIN offices
 ON employees.officeCode = offices.officeCode;

--Can shorten the entity names using "AS" employee e, offices o and customers c
 SELECT customerName, e.firstName, e.lastName, o.country, o.city FROM customers AS c JOIN employees
 as e 
 ON c.salesRepEmployeeNumber = e.employeeNumber
 JOIN offices as o
 ON e.officeCode = o.officeCode;

select * from orders;
 select orderNumber, status, comments from orders WHERE
status !="Shipped";

select orderNumber, status, comments from orders WHERE
status !="Shipped" AND comments LIKE "%complain%";

select orderNumber, status, comments from orders WHERE
status !="Shipped" AND (comments LIKE "%complain%" OR comments LIKE "%dispute%");

select orderNumber, status, comments, orders.customerNumber, customers.customerName from orders
JOIN customers
ON orders.customerNumber = customers.customerNumber
WHERE
status !="Shipped" AND (comments LIKE "%complain%" OR comments LIKE "%dispute%");

--Find all the customers and their sales rep
SELECT * FROM customers JOIN employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber;

 -- INNER JOIN //Must have salesrep for every customer

 -- LEFT JOIN: //no salesrep also will have
 SELECT * FROM customers LEFT JOIN employees
 ON customers.salesRepEmployeeNumber = employees.employeeNumber;
SELECT * FROM customers RIGHT JOIN employees
ON customers.salesRepEmployeeNumber = employees.employeeNumber;

--FULL OUTER JOIN is a combination of LEFT and RIGHT join but not supported by MySQL

--- DATES
-- MySQL uses the ISO date standard: YYYY-MM-DD
SELECT * FROM orders WHERE orderDate < "2004-01-01"

-- FInd all the orders in the month of June for the year 2003

SELECT * FROM orders WHERE orderDate >= "2003-06-01" AND orderDATE <= "2003-06-30";
SELECT * FROM orders WHERE orderDate BETWEEN '2003-06-01' AND  '2003-06-30';

-- for every order, calculate the penalty date which is 14 days from the order date
SELECT orderNumber, orderDate, Date_ADD(orderDate, INTERVAL 14 DAY) FROM orders;

select * from orders WHERE shippedDate > requiredDate;

select orderNumber, requiredDate, shippedDate, shippedDate - requiredDate as "Days late by"
from orders WHERE shippedDate > requiredDate;

select SUM(creditLimit) FROM customers;

select AVG(creditLimit) FROM customers;

select MIN(creditLimit) FROM customers WHERE creditLimit > 0;

SELECT SUM(amount) FROM payments WHERE customerNumber = 112;

SELECT COUNT(*) FROM employees;

SELECT  officeCode FROM employees;
SELECT distinct officeCode FROM employees;

-- Bruteforce method tabulate manually for each officeCode
SELECT COUNT(*) FROM employee WHERE officeCode=2;

-- for each office, count how many employees there are
SELECT officeCode, COUNT(*) FROM employees
GROUP By officeCode;
-- GROUP BY happens first before the COUNT(*) comes in.

-- for each office, count how many employees there are

-- 1st figure out the column that we are grouping by
-- 2nd what
-- 3rd count, min, or avg etc...
SELECT officeCode, COUNT(*) FROM employees
GROUP By officeCode;

SELECT country, COUNT(*) FROM customers
GROUP BY country;

-- We want to know for every customer how much they have paid us
SELECT customerNumber, SUM(amount) FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 150000;
-- GROUP BY then SELECT then HAVING

SELECT customerNumber, SUM(amount) AS `Total Paid` FROM payments
GROUP BY customerNumber
HAVING `Total Paid` > 150000;

SELECT customerName, payments.customerNumber, SUM(amount) AS `Total Paid` FROM payments
JOIN customers ON payments.customerNumber = customers.customerNumber
WHERE country = "USA"
GROUP BY payments.customerNumber, customerName
HAVING `Total Paid` > 50000
ORDER BY `Total Paid` DESC
LIMIT 10;
-- FROM and JOIN then GROUP BY then SELECT then HAVING then ORDER BY then LIMIT.
from which table join which table then group by for which column then having alias column name
then order by for the data then limit the queries returned.