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