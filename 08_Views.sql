select 
	Platform,Product_Category,sum(Order_Value_INR) as total_revenue
from Ecommerce_Delivery_Analytics_New
group by ROLLUP(Platform,Product_Category)

-----no.of order
select 
	Platform,Product_Category,count(Order_ID) as total_order
from Ecommerce_Delivery_Analytics_New
group by ROLLUP(Platform,Product_Category)

----avg order
select 
	Platform,Product_Category,avg(Order_Value_INR) as avg_total_revenue
from Ecommerce_Delivery_Analytics_New
group by ROLLUP(Platform,Product_Category)	

-----% OF TOTAL REVENUE
WITH CTE as
	(
	select 
	Platform,Product_Category,sum(Order_Value_INR) as total_revenue
	from Ecommerce_Delivery_Analytics_New
	group by rollup (platform,product_category)
)
SELECT
	platform,product_category,total_revenue,
	CASE 
        WHEN total_revenue IS NULL THEN NULL
        ELSE (total_revenue * 100.0) / (SELECT total_revenue FROM CTE WHERE Platform IS NULL AND Product_Category IS NULL)
    END AS percentage_of_total
from CTE


----------CUBE----------------------------
select 
	Platform,Product_Category,sum(Order_Value_INR) as total_revenue
from Ecommerce_Delivery_Analytics_New
group by CUBE(Platform,Product_Category)


select 
	Platform,Product_Category,COUNT(Order_ID) as total_ORDER
from Ecommerce_Delivery_Analytics_New
group by CUBE(Platform,Product_Category)

-----------VIEW------------------
CREATE VIEW vw_Platform_KPI AS
SELECT 
    Platform,
    Product_Category,
	COUNT(Order_ID) as total_ORDER,
    SUM(Order_Value_INR) AS total_revenue,
	AVG(Order_Value_INR) as AVG_revenue,
	AVG(ord) as average delivery_time
FROM Ecommerce_Delivery_Analytics_New
GROUP BY Platform, Product_Category;

