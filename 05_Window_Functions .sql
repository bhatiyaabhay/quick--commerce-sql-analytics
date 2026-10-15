------****ROW NUMBER**************
select 
Customer_ID,
Order_ID,
Order_Value_INR,
ROW_NUMBER() over (partition by customer_id order by order_value_inr) as [Order Number]
from Ecommerce_Delivery_Analytics_New


--------------------------------------
with highest_order as(
select 
Customer_ID,
Order_ID,
Order_Value_INR,
ROW_NUMBER() over (partition by customer_id order by order_value_inr desc) as [Order Number]
from Ecommerce_Delivery_Analytics_New
)

select customer_id ,
order_id,
order_value_inr,
[order number]
from highest_order
where [order number]=1
order by customer_id asc;



---------------------------------------------------------------
-----******RANK***********
with top_3 as(
select 
Platform,
Order_ID,
Order_Value_INR,
RANK() over (partition by platform order by order_value_inr desc) as [rank]
from Ecommerce_Delivery_Analytics_New
)

SELECT 
    Platform,
    Order_ID,
    Order_Value_INR,
    [rank]
FROM top_3
WHERE [rank] <= 3 
ORDER BY Platform, [rank];

---------------------------------------------------------------------------
with top_3 as(
select 
Product_Category,
Order_ID,
Order_Value_INR,
RANK() over (partition by product_category order by order_value_inr desc) as [product wise rank]
from Ecommerce_Delivery_Analytics_New
)

SELECT 
    Product_Category,
    Order_ID,
    Order_Value_INR,
    [product wise rank]
FROM top_3
WHERE [product wise rank] = 1 
order by Product_Category,[product wise rank]

----********RDENSE RANK***************

with top_3 as(
select 
Platform,
Order_ID,
Order_Value_INR,
DENSE_RANK() over (partition by platform order by order_value_inr desc) as [rank]
from Ecommerce_Delivery_Analytics_New
)

SELECT 
    Platform,
    Order_ID,
    Order_Value_INR,
    [rank]
FROM top_3
WHERE [rank] <= 3 
ORDER BY Platform, [rank];

---------------------------------------------------------------------------
with top_3 as(
select 
Product_Category,
Order_ID,
Order_Value_INR,
DENSE_RANK() over (partition by product_category order by order_value_inr desc) as [product wise rank]
from Ecommerce_Delivery_Analytics_New
)

SELECT 
    Product_Category,
    Order_ID,
    Order_Value_INR,
    [product wise rank]
FROM top_3
WHERE [product wise rank] = 1 
order by Product_Category,[product wise rank]























