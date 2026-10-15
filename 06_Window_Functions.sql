select 
Customer_ID,
Order_ID,
Order_Value_INR,
LAG(Order_Value_INR) over (partition by customer_id order by order_id) as previous
from Ecommerce_Delivery_Analytics_New

-----difference
select 
Customer_ID,
Order_ID,
Order_Value_INR,
LAG(Order_Value_INR) over (partition by customer_id order by order_id) as previous,
Order_Value_INR - LAG(Order_Value_INR) OVER (PARTITION BY Customer_ID ORDER BY Order_id) AS value_difference
from Ecommerce_Delivery_Analytics_New

-----lead
select 
Customer_ID,
Order_ID,
Order_Value_INR,
LAG(Order_Value_INR) over (partition by customer_id order by order_id) as previous,
lead(Order_Value_INR) over (partition by customer_id order by order_id) as next_order_value
from Ecommerce_Delivery_Analytics_New


---------customer with higher value than previous order
with rankorder as(
select Customer_ID,
Order_Value_INR,
lag(Order_Value_INR) over (partition by customer_id order by order_id) as previous_order
from Ecommerce_Delivery_Analytics_New
)
select
count(*) as high_order_count
from rankorder
where  order_value_inr > previous_order