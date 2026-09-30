-- BATCH 1
/* Q1 — Grand Total
Display every order with:
order_id
customer_id
amount
The total amount of all orders as grand_total*/

select order_id,customer_id,amount,
sum(amount) over() as grand_total
from orders;

/* Q2 — Customer Total
Display every order with:
•	order_id 
•	customer_id 
•	amount 
•	Total amount spent by that customer as customer_total */

select order_id,customer_id,amount,
sum(amount) over(partition by customer_id)
as customer_total
from orders;

/*Q3 — Customer Average Order Value
Display every order with:
•	order_id 
•	customer_id 
•	amount 
•	Average order amount for that customer as customer_avg_order */
select order_id,customer_id,amount,
avg(amount) over(partition by customer_id)
as customer_avg
from orders;

/*Q4 — Customer Order Count
Display every order with:
•	order_id 
•	customer_id 
•	amount 
•	Number of orders placed by that customer as customer_order_count */
select order_id,customer_id,amount,
count(customer_id) over(partition by customer_id)
as total_orders
from orders;

/*Q5 — Overall Order Rank
Rank all orders from highest to lowest amount.
Return:
•	order_id 
•	customer_id 
•	amount 
•	order_rank */
select order_id,customer_id,amount,
rank() over(order by amount desc)
as order_amount_rank
from orders;

/*Q6 — Customer Order Rank
Rank each customer's orders from highest to lowest amount.
Return:
•	customer_id 
•	order_id 
•	amount 
•	customer_order_rank */
select customer_id,order_id, amount,
rank() over(partition by customer_id order by amount desc)
as customer_order_rank
from orders;

/*Q7 — Unique Order Number per Customer
Assign a unique sequential number to each customer's orders based on order_date, from oldest to newest.
Return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	order_number */

select customer_id,order_id,order_date,amount,
row_number() over(partition by customer_id order by order_date)
as order_no
from orders;

/*Q8 — Highest-Value Order per Customer
Using a window function, identify each customer's highest-value order.
Return:
•	customer_id 
•	order_id 
•	amount 
•	order_rank */
with ranked_orders as(
select customer_id,order_id,amount,
rank() over(partition by customer_id order by amount desc)
as order_rank
from orders
)
select * from ranked_orders
where order_rank=1;

/*Q9 — Rank Products by Price Within Category
Using the products table, rank products from highest to lowest price within each category.
Return:
•	product_id 
•	product_name 
•	category 
•	price 
•	category_price_rank */
select product_id,product_name,category,price,
rank() over(partition by category order by price desc)
as category_price_rank
from products;

/* Q10 — Customer Revenue Rank
First calculate each customer's total order value using a window function.
Then rank customers based on their total spending.
Return:
•	customer_id 
•	order_id 
•	amount 
•	customer_total 
•	customer_revenue_rank */
with amount_rank as(
select customer_id,order_id, amount,
sum(amount) over(partition by customer_id) as total_amount
from orders
) 
select customer_id,order_id, amount, total_amount,
rank() over(order by total_amount desc) as customer_revenue_rank
from amount_rank;







