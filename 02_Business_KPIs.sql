select * from Ecommerce_Delivery_Analytics_New



--total revenue
select SUM(Order_Value_INR) as [total value] from dbo.Ecommerce_Delivery_Analytics_New


select PLATFORM,SUM(Order_Value_INR) as [platform revenue] from dbo.Ecommerce_Delivery_Analytics_New
group by Platform


select Product_Category,SUM(Order_Value_INR) as [product revenue] from dbo.Ecommerce_Delivery_Analytics_New
group by Product_Category


--average revenue
select AVG(Order_Value_INR) as [avg value] from dbo.Ecommerce_Delivery_Analytics_New


select PLATFORM,avg(Order_Value_INR) as [avg platform revenue] from dbo.Ecommerce_Delivery_Analytics_New
group by Platform


select Product_Category,avg(Order_Value_INR) as [avg product revenue] from dbo.Ecommerce_Delivery_Analytics_New
group by Product_Category

-----average delivery time
select AVG(Delivery_Time_Minutes) as [avg delivery time] from dbo.Ecommerce_Delivery_Analytics_New

-----average service rating
select AVG(Service_Rating) as [avg rating] from dbo.Ecommerce_Delivery_Analytics_New

--overall delivery delay percentage
select sum(CASE WHEN Delivery_Delay > 0 THEN 1 ELSE 0 END)*100/count(Delivery_Delay) as [delivery delay] from dbo.Ecommerce_Delivery_Analytics_New

