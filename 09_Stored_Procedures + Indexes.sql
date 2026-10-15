

CREATE PROCEDURE sp_PlatformKPIs
AS
BEGIN
    SELECT 
        Platform,
        COUNT(Order_ID) AS total_ORDER,
        SUM(Order_Value_INR) AS total_revenue,
        AVG(Order_Value_INR) AS AVG_revenue,
        AVG(DELIVERY_TIME_MINUTES) AS AVERAGE_DELIVERY_TIME,
        AVG(Service_Rating) AS SERVICE_RATING,
        SUM(CAST(Delivery_Delay AS FLOAT)) * 100.0 / COUNT(Delivery_Delay) AS [%_DELIVERY_DELAY],
        SUM(CAST(Refund_Requested AS FLOAT)) * 100.0 / COUNT(Refund_Requested) AS [%_REFUN_REQUESTED]
    FROM Ecommerce_Delivery_Analytics_New
    GROUP BY Platform
END
GO

EXEC sp_PlatformKPIs


--------sp_plateform_kpi_by_name

CREATE PROCEDURE Sp_Plateform_Kpi_By_Name
@PlatformName NVARCHAR(50)
AS
BEGIN
    SELECT 
        Platform,
        COUNT(Order_ID) AS total_ORDER,
        SUM(Order_Value_INR) AS total_revenue,
        AVG(Order_Value_INR) AS AVG_revenue,
        AVG(DELIVERY_TIME_MINUTES) AS AVERAGE_DELIVERY_TIME,
        AVG(Service_Rating) AS SERVICE_RATING,
        SUM(CAST(Delivery_Delay AS FLOAT)) * 100.0 / COUNT(Delivery_Delay) AS [%_DELIVERY_DELAY],
        SUM(CAST(Refund_Requested AS FLOAT)) * 100.0 / COUNT(Refund_Requested) AS [%_REFUN_REQUESTED]
    FROM Ecommerce_Delivery_Analytics_New
    WHERE Platform = @PlatformName
    GROUP BY Platform
END
GO

EXEC Sp_Plateform_Kpi_By_Name
@PlatformName ='Blinkit'



----------------index
CREATE NONCLUSTERED INDEX IX_Ecommerce_customer 
ON Ecommerce_Delivery_Analytics_New (customer_id);

CREATE NONCLUSTERED INDEX IX_Ecommerce_Platform 
ON Ecommerce_Delivery_Analytics_New (Platform );


select Customer_ID from Ecommerce_Delivery_Analytics_New