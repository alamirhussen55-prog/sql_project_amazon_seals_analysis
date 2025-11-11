create database  AmazonSeals;
use AmazonSeals;
CREATE TABLE  Orders (
    Order_ID VARCHAR(20) PRIMARY KEY,
    
    Product VARCHAR(100),
    Category VARCHAR(50),
    Price FLOAT,
    Quantity INT,
    Total_Sales FLOAT,
    Customer_Name VARCHAR(100),
    Customer_Location VARCHAR(100),
    Payment_Method VARCHAR(50),
    Status VARCHAR(50)
);
BULK INSERT dbo.Orders
FROM '.\amazon.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,            -- skips header
    FIELDTERMINATOR = ',',   -- comma separator
    ROWTERMINATOR = '\n',    -- new line for each row
    TABLOCK,
    CODEPAGE = '65001'  
);
--Generic question 
--how many locations are presented in the dataset
--calling locations view 
select * from locations;
--product analysis 
-- what is the most paid product for completed status orders
--calling view 
select * from mostPaidProduct;
-- What is the most common payment method?
select top 1 Payment_Method,count(Payment_Method) as common_payment_method from Orders group by Payment_Method order by common_payment_method desc;
-- 2.How many unique payment methods does the data have?
SELECT Payment_Method, COUNT(*) as repeatings FROM Orders group by Payment_Method;

--what is the most saled category
select top 1 Orders.Category,sum(Orders.Total_Sales) as total_sales from Orders group by Category Order by total_sales desc;
-- what is the top customer in sales value
select top 1 Customer_Name,sum(Total_Sales) as sales_value from Orders group by Customer_Name order by sales_value desc;

-- .How many unique customer  does the data have?
SELECT COUNT(DISTINCT Orders.Customer_Name) FROM Orders;
-- 9.Retrieve each customer name and add a column has_5%_discount for customer who bought more than the average sales 
alter table Orders add has_Discount bit default 0;

UPDATE Orders

SET has_Discount = 
    CASE 
        WHEN Total_Sales > (SELECT AVG(Total_Sales) FROM Orders where status='Completed') THEN 1
        ELSE 0
    END;






