# SQL Window Functions — Running Totals, Cumulative Analysis & Row Comparisons

A practical SQL learning project focused on mastering **MySQL Window Functions** through business-oriented order and customer analysis.

This project covers two batches of advanced window-function exercises, progressing from cumulative calculations to previous/next row comparisons and customer-level behavioral analysis.

## Author

**Shorya Dev Bisht**
https://www.linkedin.com/in/shorya-bisht-a20144349/

---

## Project Objective

The objective of this project is to develop strong practical skills in using SQL Window Functions for analytical tasks that commonly appear in **Data Analyst, Business Analyst, Web Analyst, and BI Analyst** roles.

The exercises focus on answering questions such as:

* How much revenue has accumulated over time?
* How much has each customer spent cumulatively?
* What is the running average of order values?
* What is the highest order value reached so far?
* Which order number is each transaction for a customer?
* How much of total revenue has accumulated at each point?
* What percentage of revenue comes from each customer?
* What was a customer's previous order?
* What is their next order?
* How much did the order value change compared with the previous or next order?

---

## Database Structure

The exercises use a relational e-commerce-style database containing three tables.

### 1. `customers`

| Column          | Data Type   | Description                          |
| --------------- | ----------- | ------------------------------------ |
| `customer_id`   | INT         | Primary key identifying the customer |
| `customer_name` | VARCHAR(20) | Customer name                        |
| `city`          | VARCHAR(20) | Customer's city                      |

### 2. `orders`

| Column        | Data Type       | Description                       |
| ------------- | --------------- | --------------------------------- |
| `order_id`    | INT             | Primary key identifying the order |
| `customer_id` | INT             | Customer who placed the order     |
| `product_id`  | INT             | Product associated with the order |
| `amount`      | DECIMAL/NUMERIC | Order value                       |
| `status`      | VARCHAR         | Order status                      |
| `order_date`  | DATE            | Date of the order                 |

### 3. `products`

| Column         | Data Type       | Description                         |
| -------------- | --------------- | ----------------------------------- |
| `product_id`   | INT             | Primary key identifying the product |
| `product_name` | VARCHAR         | Product name                        |
| `category`     | VARCHAR         | Product category                    |
| `price`        | DECIMAL/NUMERIC | Product price                       |

### Relationships

```text
customers
    │
    │ customer_id
    ▼
orders
    │
    │ product_id
    ▼
products
```

The `orders` table acts as the central transactional table for the window-function analysis.

---

## Batch 1 — Window Functions Fundamentals
Objective

Batch 1 introduced the fundamentals of SQL Window Functions using the orders and products tables. The focus was on performing analytical calculations while preserving the original transaction-level rows.

Key SQL Concepts Learned
OVER()
PARTITION BY
ORDER BY inside window functions
SUM() OVER()
AVG() OVER()
COUNT() OVER()
RANK()
ROW_NUMBER()
Combining Window Functions with CTEs
Customer-level analytical calculations
Overall dataset calculations
Ranking within groups
Sequential ordering within groups
Core Learning

The central concept of Batch 1 was understanding that Window Functions perform analytical calculations without removing the individual rows from the result.

For example:

### GROUP BY
Orders → Groups → One row per group

### Window Function
Orders → Analytical Calculation → Original order rows preserved

This makes Window Functions particularly useful for business analysis where transaction-level detail and summary metrics are required together.

## Business Analysis Applications

The concepts from Batch 1 can be applied to:

Customer revenue analysis
Customer AOV analysis
Customer purchase frequency
High-value order identification
Customer ranking
Product price ranking
Revenue contribution analysis
Customer segmentation
Transaction-level performance analysis
Batch 1 Outcome

By completing Batch 1, the foundation was established for more advanced Window Function analysis, including running totals, cumulative metrics, previous/next row comparisons, customer behavior analysis, and revenue trends.

# Batch 2 — Running Totals & Cumulative Analysis

Batch 2 focused on understanding how window functions can analyze the progression of business metrics without collapsing individual rows.

### Techniques Practiced

* `SUM() OVER()`
* `AVG() OVER()`
* `MAX() OVER()`
* `COUNT() OVER()`
* `ROW_NUMBER()`
* `PARTITION BY`
* `ORDER BY`
* Running totals
* Running averages
* Running maximums
* Cumulative counts
* Customer-level cumulative analysis
* Revenue contribution analysis
* Combining multiple window calculations using CTEs

### Business Analysis Covered

The batch included:

1. Overall running revenue
2. Customer-level running revenue
3. Running average of order amounts
4. Customer running average
5. Running maximum order value
6. Customer maximum order value so far
7. Cumulative order count
8. Customer order sequencing and cumulative revenue
9. Running revenue percentage
10. Customer contribution to total revenue

These exercises helped establish the difference between **aggregating data into fewer rows** and **calculating analytical metrics while preserving every transaction row**.

---

# Batch 3 — Previous & Next Order Analysis

Batch 3 moved from cumulative analysis into **row-to-row comparison**.

The focus was on understanding how an individual transaction relates to another transaction belonging to the same customer.

### Techniques Practiced

* `LAG()`
* `LEAD()`
* `AVG() OVER()`
* `RANK()`
* `PARTITION BY`
* `ORDER BY`
* Difference calculations
* Percentage-change calculations
* Customer-level comparisons
* Windowed averages
* `CASE` with window-function results
* CTEs for analytical calculations

### Business Analysis Covered

The exercises included:

1. Previous order amount
2. Difference from previous order
3. Percentage change from previous order
4. Next order analysis
5. Previous vs. next order comparison
6. Order amount compared with customer average
7. Customer order ranking
8. Highest-value order identification
9. Above/equal/below customer average classification
10. Previous and next order difference analysis

This batch strengthened the ability to answer questions around **customer purchasing behavior, order progression, and transaction-level changes**.

---

# Key SQL Concepts Mastered

### 1. `PARTITION BY`

Used to restart analytical calculations for each customer.

```sql
SUM(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)
```

This allows the same calculation to be performed independently for every customer.

---

### 2. `ORDER BY` Inside Window Functions

Used to establish the analytical sequence.

```sql
LAG(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)
```

This defines which order is considered previous.

---

### 3. Running Calculations

Window functions can calculate cumulative metrics while retaining every transaction.

```sql
SUM(amount) OVER(
    ORDER BY order_date
)
```

Unlike `GROUP BY`, this does not collapse the underlying order rows.

---

### 4. `LAG()`

Used for previous-row analysis.

```sql
LAG(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)
```

Useful for:

* Previous purchase value
* Order-to-order change
* Growth calculations
* Customer behavior analysis

---

### 5. `LEAD()`

Used for next-row analysis.

```sql
LEAD(amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
)
```

Useful for:

* Next purchase value
* Future transaction comparison
* Customer sequence analysis

---

### 6. Windowed Aggregations

Functions such as `AVG()`, `SUM()`, and `MAX()` can be used without collapsing the dataset.

Example:

```sql
AVG(amount) OVER(
    PARTITION BY customer_id
)
```

This calculates each customer's average while keeping every order available for comparison.

---

### 7. CTE + Window Function Pattern

A common analytical SQL pattern used throughout the exercises was:

```sql
WITH analysis AS (
    SELECT ...,
           window_function(...) AS metric
    FROM orders
)
SELECT ...
FROM analysis;
```

This separates the analytical calculation from the final business logic and improves query readability.

---

## Skills Mastered

### SQL Technical Skills

* MySQL Window Functions
* `SUM() OVER()`
* `AVG() OVER()`
* `MAX() OVER()`
* `COUNT() OVER()`
* `ROW_NUMBER()`
* `RANK()`
* `LAG()`
* `LEAD()`
* `PARTITION BY`
* Window `ORDER BY`
* CTEs
* Conditional logic with `CASE`
* Percentage calculations
* Difference calculations

### Analytical Skills

* Cumulative revenue analysis
* Customer spending analysis
* Order sequencing
* Customer benchmarking
* Revenue contribution analysis
* Previous/next transaction analysis
* Order-value change analysis
* Customer behavior comparison
* Transaction-level business metrics

---

## Business Analyst Perspective

The purpose of these exercises is not simply to memorize SQL syntax.

The goal is to translate transactional data into business questions.

For example:

```text
Raw Orders
    ↓
Window Functions
    ↓
Customer / Order Metrics
    ↓
Behavior Comparison
    ↓
Business Insight
```

A simple order table can therefore be transformed into metrics that help answer questions about **customer value, purchasing behavior, revenue concentration, and transaction trends**.

---

## Learning Progression

```text
Basic SQL
   ↓
Aggregation
   ↓
JOINs
   ↓
Subqueries & CTEs
   ↓
Advanced Aggregation
   ↓
Window Functions
   ├── Running & Cumulative Analysis
   └── Previous & Next Row Analysis
```

These 3 batches represent the transition from traditional aggregation to more advanced **analytical SQL thinking**.

---

## Tools Used

* MySQL
* MySQL Workbench
* SQL
* Relational database concepts

---

## Project Outcome

After completing these exercises, I can use MySQL Window Functions to perform analytical calculations while preserving transaction-level detail.

The project strengthened my ability to move from:

**"What is the total?"**

to:

**"How does this transaction compare with what happened before, after, or within the customer's overall behavior?"**

This is an important foundation for practical SQL-based business and data analysis.

---

## Author

**Shorya Dev Bisht**
https://www.linkedin.com/in/shorya-bisht-a20144349/

