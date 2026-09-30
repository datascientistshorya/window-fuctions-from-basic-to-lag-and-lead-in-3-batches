-- LAG(), LEAD() & Period-over-Period Analysis
/*Q1 — Previous Order Amount
For each order, show:
•	order_id 
•	customer_id 
•	order_date 
•	amount 
•	previous order amount for the same customer */
select order_id,customer_id,order_date, amount,
lag(amount) over(partition by customer_id order by order_date) as previous_order_amount 
from orders;

/*Q2 — Change From Previous Order
For each customer's order, calculate:
•	order_id 
•	customer_id 
•	order_date 
•	amount 
•	previous order amount 
•	amount_change 
Where:
amount_change = current amount - previous amount
The first order for each customer should return NULL for the previous amount and change.*/
with amount_calc as(
	select order_id,customer_id,order_date,amount,
	lag(amount) over(partition by customer_id order by order_date)as previous_order_amount
    from orders
)
select *,
amount-previous_order_amount as order_amount_difference from amount_calc;

/*Q3 — Customer Order Growth %
For every order after a customer's first order, calculate:
growth_pct =
(current amount - previous amount)
/
previous amount × 100
Return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	previous_amount 
•	growth_pct 
Round the percentage to 2 decimal places.*/
with amount_calc as(
	select order_id,customer_id,order_date,amount,
	lag(amount) over(partition by customer_id order by order_date)as previous_order_amount
    from orders
)
select *,
round(
(amount-previous_order_amount)/previous_order_amount *100,2) as growth_percentage
 from amount_calc;

/*Q4 — Next Order Analysis
For every order, show:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	next order date 
•	next order amount */
select customer_id,order_id,order_date,amount,
lead(order_date) over(order by order_date) as next_order_date,
lead(amount) over(order by order_date) as next_order_amount
from orders;

/*Q5 — Days Until Next Order
For each customer's order, calculate the number of days until their next order.
Return:
•	customer_id 
•	order_id 
•	order_date 
•	next_order_date 
•	days_to_next_order */

select customer_id,order_id,order_date,amount,
lead(order_date) over(partition by customer_id order by order_date) as next_order_date,
lead(amount) over(partition by customer_id order by order_date) as next_order_amount
from orders;

/*Q7 — Difference From Next Order
For every order, show:
customer_id
order_id
order_date
amount
next_order_amount
amount_difference
Where:
amount_difference = next_order_amount - current amount
The next order should be for the same customer*/
	with rev_calc as(
	select customer_id,order_id,order_date,amount,
	lead(amount) over(order by order_date) as next_amount
	from orders
	)
	select*, next_amount - amount as amount_difference
	from rev_calc; 
    
/*Q8 — Previous vs Current Order Percentage Change
For every order after a customer's first order, calculate:
change_pct =
(current amount - previous amount)
/
previous amount × 100
Return:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	previous_amount 
•	change_pct 
Round the percentage to 2 decimal places.*/

with amount_cal as(
	select customer_id,order_id,order_date,amount,
    lag(amount) over(partition by customer_id order by order_date) as prev_amt
    from orders
)
select* , 
round(
      (amount-prev_amt)/prev_amt *100, 2) as change_pct
from amount_cal;

/*Q9 — Customer Order vs Average
For every order, show:
customer_id
order_id
amount
customer_avg_amount
difference_from_average
order_vs_average
Where:
difference_from_average =amount - customer_avg_amount
And using CASE, classify each order as:
Above Average,Equal to Average,Below Average*/ 

with amt_cal as(
select customer_id, order_id,order_date,amount,
avg(amount) over(partition by customer_id)as customer_avg_amount
from orders
)
select*, amount-customer_avg_amount as difference_from_average,
case when amount> customer_avg_amount then 'Above Avg'
	 when amount= customer_avg_amount then 'Equals Avg'
     else 'Below Avg' end as segment
from amt_cal;

/*Q10 — Previous and Next Order Comparison
For every order, show:
•	customer_id 
•	order_id 
•	order_date 
•	amount 
•	previous_amount 
•	next_amount 
•	previous_difference 
•	next_difference 
Definitions:
previous_difference = current amount - previous amount
next_difference = next amount - current amount*/
with amt_cal as(
select customer_id,order_id,order_date,amount,
lag(amount) over(partition by customer_id order by order_date)as prev_amt,
lead(amount) over(partition by customer_id order by order_date)as next_amt
from orders
)
select* , amount-prev_amt as previous_diff,
next_amt-amount as next_diff
from amt_cal;