-- Batch 2 — Running Totals & Cumulative Analysis
/*Q1 — Running Total of All Orders
Display:
order_id
order_date
amount
running_total
Calculate the cumulative total of amount ordered by order_date from oldest to newest.*/

select order_id,order_date,amount,
sum(amount) over(order by order_date) as running_total
from orders;

/*Q2 — Customer Running Total
For each customer, calculate their cumulative spending over time.
Return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	customer_running_total 
The running total should restart for each customer.*/

select customer_id,order_id,order_date,amount,
sum(amount) over(partition by customer_id order by order_date) as running_total
from orders;

/*Q3 — Running Average of Orders
Display:
•	order_id 
•	order_date 
•	amount 
•	running_avg 
Calculate the average order amount from the first order up to the current order.
Example concept:
Order 1 → average of Order 1
Order 2 → average of Orders 1–2
Order 3 → average of Orders 1–3*/

select order_id,order_date,amount,
avg(amount) over(order by order_date) as running_avg
from orders;

/*Q4 — Customer Running Average
For each customer, calculate the cumulative average of their orders.
Return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	customer_running_avg 
The calculation should restart for every customer.*/
select customer_id,order_id,order_date,amount,
avg(amount) over(partition by customer_id order by order_date) as running_avg
from orders;

/*Q5 — Running Maximum Order
Display:
•	order_id 
•	order_date 
•	amount 
•	running_max_amount 
For each order, show the highest order amount encountered so far.
Example:
500  → 500
800  → 800
300  → 800
1000 → 1000
700  → 1000*/


/*Q6 — Customer's Highest Order So Far
For every customer, calculate the highest order amount they have placed up to that particular order.
Return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	customer_max_so_far */
select customer_id, order_id, order_date, amount,
max(amount) over(partition by customer_id order by order_date) as customer_max_so_far
from orders;

/*Q7 — Cumulative Order Count
Display:
•	order_id 
•	order_date 
•	amount 
•	orders_so_far 
Calculate how many orders have been placed up to and including each order.*/

select order_id,order_date, amount,
count(order_id) over(order by order_date) as orders_so_far 
from orders;

/*Q8 — Customer Order Number + Running Revenue
For every customer, return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	order_number 
•	customer_running_revenue 
Where:
•	order_number = customer's chronological order number 
•	customer_running_revenue = customer's cumulative spending */

select customer_id,order_id,order_date,amount,
row_number() over(partition by customer_id order by order_date) as order_no,
sum(amount) over(partition by customer_id order by order_date) as running_total
from orders;

/* Q9 — Running Revenue Percentage
For every order, calculate:
•	order_id 
•	order_date 
•	amount 
•	running_total 
•	running_revenue_percentage 
Where:
running_revenue_percentage
=
running_total / grand_total × 100
For example, if the grand total is ₹10,000 and the running total after an order is ₹4,000:
40%*/
with rev_calc as(
	select order_id,order_date,amount,
	sum(amount) over() as grand_total,
	sum(amount) over(order by order_date) as running_total
	from orders
)
select *,
running_total / grand_total * 100 as running_revenue_percentage
from rev_calc;

/*Q10 — Customer Contribution to Revenue
For every order, calculate:
•	customer_id 
•	order_id 
•	amount 
•	customer_total 
•	grand_total 
•	customer_revenue_percentage*/
with rev_pct as(
	select customer_id,order_id,amount,
    sum(amount) over() as grand_total,
    sum(amount) over(partition by customer_id) as customer_total
    from orders
)
select *, 
 customer_total/grand_total*100 as customer_revenue_percentage
 from rev_pct;




