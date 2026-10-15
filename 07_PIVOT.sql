
select 
	Platform,[not_delayed],[delayed]
from 
	(
	select 
	Platform,Customer_ID,
	case
		when Delivery_Delay=0 then 'not_delayed'
		when Delivery_Delay=1 then 'delayed'
	end as Delivery_Delay_Text
	from Ecommerce_Delivery_Analytics_New
	) as source_data
pivot
	(
	count(Customer_ID)
	for Delivery_Delay_Text in ([not_delayed], [delayed])
    ) as pivot_table;

--------------------------

select 
	Platform,[no_refund],[refund]

from
	(
	select 
	Platform,Customer_ID,
	case
		when refund_requested =0 then 'no_refund'
		when refund_requested=1 then'refund'
	end as refund_intiate
	from Ecommerce_Delivery_Analytics_New
	) as source_data
pivot
	( 
	count(customer_id)
	for refund_intiate in ([no_refund],[refund])
	) as pivot_table

------------------

select
	Platform,[Personal Care],
	[Fruits & Vegetables],
	[Beverages],
	[Grocery],
	[Dairy],
	[Snacks]
from
	(
	select 
	Platform,Order_ID,Product_Category
	from Ecommerce_Delivery_Analytics_New
	) as source_Data
pivot
	(
	count(order_id)
	for product_category in([Personal Care],
	[Fruits & Vegetables],
	[Beverages],
	[Grocery],
	[Dairy],
	[Snacks])
	)as pivot_table

----------------------
select
	Platform,[Rating 1],[Rating 2],[Rating 3],[Rating 4],[Rating 5]
from 
	(
	select 
	Platform,order_id,
	case Service_Rating
                when 1 then 'Rating 1'
                when 2 then 'Rating 2'
                when 3 then 'Rating 3'
                when 4 then 'Rating 4'
                when 5 then 'Rating 5'
    end as Service_Rating_Text
	from Ecommerce_Delivery_Analytics_New
	) as source_data
pivot
	( 
	count(order_id)
	for service_rating_text in ([Rating 1],[Rating 2],[Rating 3],[Rating 4],[Rating 5])
	)as pivot_table



select distinct product_category from dbo.Ecommerce_Delivery_Analytics_New




	
	