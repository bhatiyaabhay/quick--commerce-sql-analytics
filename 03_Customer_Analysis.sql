
------high or low
with high_low as(
select 
	Customer_ID,
	Order_Value_INR,
	lag(order_value_inr) over (partition by customer_id order by order_id) as previous
from Ecommerce_Delivery_Analytics_New
)
select
	count(case when previous>order_value_inr then 1 end) as lower_value,
	count(case when previous<order_value_inr then 1 end) as higher_value	
from high_low

---------customer spending
select 
	top 10 Customer_ID,
	count(order_id)as number_of_order,
	avg(Order_Value_INR) as average_value,
	sum(Order_Value_INR) as customer_spend
from Ecommerce_Delivery_Analytics_New
group by Customer_ID
order by customer_spend desc

---------customer segmentation
with customer_seg as(
select 
	Customer_ID,
	sum(Order_Value_INR) as customer_spend
from Ecommerce_Delivery_Analytics_New 
group by Customer_ID
) 
select 
	Customer_ID,
	customer_spend,
	case
		when customer_spend<6000 then 'low_value'
		when customer_spend between 6000 and 12000 then 'medium_value'
		else 'high_value'
	end as customer_segmentation
from customer_seg
