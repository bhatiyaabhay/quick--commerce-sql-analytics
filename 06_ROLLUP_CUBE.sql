
CREATE VIEW vw_Platform_KPI AS
SELECT 
    Platform,
	COUNT(Order_ID) as total_ORDER,
    SUM(Order_Value_INR) AS total_revenue,
	AVG(Order_Value_INR) as AVG_revenue,
    AVG(DELIVERY_TIME_MINUTES) AS AVERAGE_DELIVERY_TIME,
    AVG(Service_Rating) AS SERVICE_RATING,
    SUM(CAST(Delivery_Delay AS FLOAT)) *100.0/COUNT(DELIVERY_DELAY) AS [%_DELIVERY_DELAY],
    SUM(CAST(Refund_Requested AS FLOAT)) *100.0/COUNT(Refund_Requested) AS [%_REFUN_REQUESTED]
FROM Ecommerce_Delivery_Analytics_New
GROUP BY Platform
GO

SELECT * FROM vw_Platform_KPI


----------category

CREATE VIEW vw_category_KPI AS
SELECT 
    Product_Category,
	COUNT(Order_ID) as total_ORDER,
    SUM(Order_Value_INR) AS total_revenue,
	AVG(Order_Value_INR) as AVG_revenue,
    AVG(DELIVERY_TIME_MINUTES) AS AVERAGE_DELIVERY_TIME,
    AVG(Service_Rating) AS SERVICE_RATING,
    SUM(CAST(Delivery_Delay AS FLOAT)) *100.0/COUNT(DELIVERY_DELAY) AS [%_DELIVERY_DELAY],
    SUM(CAST(Refund_Requested AS FLOAT)) *100.0/COUNT(Refund_Requested) AS [%_REFUN_REQUESTED]
FROM Ecommerce_Delivery_Analytics_New
GROUP BY Product_Category
GO

SELECT * FROM vw_category_KPI

