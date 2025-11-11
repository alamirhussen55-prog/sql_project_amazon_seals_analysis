create view mostPaidProduct as 
select top 1 Product,sum(Total_Sales) as Maximum_sales from Orders where Status='Completed' group by Product order by  Maximum_sales desc ; 
