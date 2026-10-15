SELECT 
    Platform,
    COUNT(Order_ID) AS total_orders,
    SUM(Order_Value_INR) AS total_revenue,
    AVG(Order_Value_INR) AS avg_order_value,
    AVG(CAST(DELIVERY_TIME_MINUTES AS FLOAT)) AS avg_delivery_time,
    AVG(CAST(Service_Rating AS FLOAT)) AS avg_service_rating,
    SUM(CAST(Delivery_Delay AS FLOAT)) * 100.0 / COUNT(Delivery_Delay) AS delivery_delay_pct,
    SUM(CAST(Refund_Requested AS FLOAT)) * 100.0 / COUNT(Refund_Requested) AS refund_request_pct,
    DENSE_RANK() OVER (ORDER BY SUM(Order_Value_INR) DESC) AS revenue_rank,
    DENSE_RANK() OVER (ORDER BY AVG(CAST(Service_Rating AS FLOAT)) DESC) AS customer_satisfaction_rank,
    DENSE_RANK() OVER (ORDER BY AVG(CAST(DELIVERY_TIME_MINUTES AS FLOAT)) ASC) AS speed_rank,
    DENSE_RANK() OVER (ORDER BY SUM(CAST(Delivery_Delay AS FLOAT)) * 100.0 / COUNT(Delivery_Delay) ASC) AS reliability_rank
FROM Ecommerce_Delivery_Analytics_New
GROUP BY Platform
ORDER BY total_revenue DESC;

-----------------
WITH CustomerSpending AS (
    SELECT 
        Customer_ID,
        COUNT(Order_ID) AS total_orders,
        SUM(Order_Value_INR) AS total_spending,
        AVG(Order_Value_INR) AS avg_order_value,
        RANK() OVER (ORDER BY SUM(Order_Value_INR) DESC) AS customer_rank
    FROM Ecommerce_Delivery_Analytics_New
    GROUP BY Customer_ID
)
SELECT 
    Customer_ID,
    total_orders,
    total_spending,
    avg_order_value,
    customer_rank
FROM CustomerSpending
WHERE customer_rank <= 10
ORDER BY customer_rank;

-------------------
with CustomerBehaviour as(
    select
        Customer_ID,
        Order_ID,
        Order_Value_INR,
        lag(order_value_inr) over (partition by customer_id order by order_id) as previous
    from Ecommerce_Delivery_Analytics_New
),
OrderComparisons AS (
    SELECT 
        Customer_ID,
        COUNT(Order_ID) AS total_orders,
        SUM(CASE WHEN Order_value_inr > previous THEN 1 ELSE 0 END) AS increased_orders
    FROM CustomerBehaviour
    GROUP BY Customer_ID
 )
select 
    Customer_ID,
    total_orders,
    increased_orders,
    case
        when total_orders > 1 then (cast(increased_orders as float)*100.0)/(total_orders-1)
        else 0
    end as pct_orders_increasing
from OrderComparisons


-------------------------
with ratingExp as(
    select
        Customer_ID,
        COUNT(Order_ID) AS total_orders,
        sum (order_value_inr) as total_spending,
        avg(cast(service_rating as float)) as avg_rating
    from Ecommerce_Delivery_Analytics_New
    group by Customer_ID
)
select 
    Customer_ID,
    total_orders,
    total_spending,
    avg_rating
from ratingExp
WHERE total_spending > 10000 
  AND avg_rating > 3
ORDER BY total_spending DESC;