/* SQL Exercise
====================================================================
We will be working with database northwind.db we have set up and connected to in the activity Connect to Remote PostgreSQL Database earlier.


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
-- Q1. Write a query to get Product name and quantity/unit.
*/

SELECT productname, quantityperunit FROM products;

/* TASK II
Q2. Write a query to get the most expensive and the least expensive Product (name and unit price) (2 separate queries)
*/

SELECT productname, unitprice FROM products
    ORDER BY unitprice DESC;

SELECT productname, unitprice FROM products
    ORDER BY unitprice ASC;


/* TASK III
Q3. Write a query to count current and discontinued products.
*/

SELECT COUNT(unitsinstock) AS "Current", COUNT(discontinued) AS "Discontinued" FROM products;

/* TASK IV
Q4. Select all product names and their category names (77 rows)
*/

SELECT productname, categoryname  FROM products
    JOIN categories ON products.categoryid=categories.categoryid;

/* TASK V
Q5. Select all product names, unit price and the supplier region that don't have suppliers from the country USA. (65 rows)
*/

SELECT productname, unitprice, region FROM products
    JOIN suppliers ON products.supplierid=suppliers.supplierid
    WHERE country NOT LIKE 'USA';

/* TASK VI
Q6. Get the total quantity of orders sold.( 51317)
*/

SELECT SUM(quantity) AS "Total" FROM order_details;

/* TASK VII
Q7. Get the total quantity of orders sold for each order.(830 rows)
*/

SELECT SUM(quantity) AS "Total", orders.orderid FROM order_details
    JOIN orders ON order_details.orderid=orders.orderid
    GROUP BY orders.orderid;

/* TASK VIII
Q8. Get the number of employees who have been working more than 5 year in the company. (9 rows)
*/

SELECT employeeid, hiredate, hiredate+INTERVAL '5 year' AS "Working" FROM employees;

select  count(*) from employees 
where extract( year FROM hiredate )::int<(2022-5); 