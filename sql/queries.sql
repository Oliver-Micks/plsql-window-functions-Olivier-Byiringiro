# Ranking Function 
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.region,
    SUM(t.amount) AS total_revenue, --totals each customer’s spending
    ROW_NUMBER() OVER (ORDER BY SUM(t.amount) DESC) AS row_number_rank, --assigns a unique number to each customer from highest to lowest revenue
    RANK() OVER (ORDER BY SUM(t.amount) DESC) AS rank_value, --assigns ranks, but gaps occur
    DENSE_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS dense_rank_value, --assigns ranks without gaps
    PERCENT_RANK() OVER (ORDER BY SUM(t.amount) DESC) AS percent_rank_value --relative position (0 = highest revenue, 1 = lowest)
FROM 
    customers c
JOIN 
    transactions t ON c.customer_id = t.customer_id
GROUP BY 
    c.customer_id, c.name, c.region
ORDER BY 
    total_revenue DESC;

# Aggregate Function
SELECT
    t.transaction_id,                    
    c.name AS customer_name,             
    t.sale_date,                      
    t.amount,                             
    SUM(t.amount) OVER (                  
        PARTITION BY t.customer_id
        ORDER BY t.sale_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total,
    AVG(t.amount) OVER (                  -- Average of current and previous sale
        PARTITION BY t.customer_id
        ORDER BY t.sale_date
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS avg_recent_two_sales,
    MIN(t.amount) OVER (                  -- Minimum sale up to current transaction
        PARTITION BY t.customer_id
        ORDER BY t.sale_date
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS min_sale_so_far,
    MAX(t.amount) OVER (                  -- Maximum sale up to current transaction
        PARTITION BY t.customer_id
        ORDER BY t.sale_date
        RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS max_sale_so_far
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY t.customer_id, t.sale_date;

# Navigation Function
-- LAG()
-- Show each customer's current sale and the previous sale
SELECT 
    t.transaction_id,                          
    c.name AS customer_name,                
    t.amount AS current_sale,                   -
    LAG(t.amount) OVER (PARTITION BY c.customer_id ORDER BY t.sale_date) AS previous_sale -- Previous transaction amount for the same customer      
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY c.customer_id, t.sale_date;           -- Order by customer and date

-- LAG() Growth
-- Show percentage change from previous sale
SELECT 
    t.transaction_id,                     
    c.name AS customer_name,                
    t.amount AS current_sale,                   
    LAG(t.amount) OVER (PARTITION BY c.customer_id ORDER BY t.sale_date) AS previous_sale, -- Previous transaction amount                                               
    ROUND(((t.amount - LAG(t.amount) OVER (PARTITION BY c.customer_id ORDER BY t.sale_date)) 
           / LAG(t.amount) OVER (PARTITION BY c.customer_id ORDER BY t.sale_date)) * 100, 2) AS growth_pct -- Percentage change compared to previous sale                                                
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY c.customer_id, t.sale_date;           -- Order by customer and date

-- LEAD()
SELECT 
    t.transaction_id,                           
    c.name AS customer_name,                    
    t.amount AS current_sale,                  
    LEAD(t.amount) OVER (PARTITION BY c.customer_id ORDER BY t.sale_date) AS next_sale -- Next transaction amount for the same customer                                                
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id
ORDER BY c.customer_id, t.sale_date; -- Order by customer and date

# Distribution Function
-- LEAD(4)
SELECT 
    c.name AS customer_name,                   
    SUM(t.amount) AS total_spent,              
    NTILE(4) OVER (ORDER BY SUM(t.amount) DESC) AS quartile  -- Divide customers into 4 quartiles
FROM transactions t                                              
JOIN customers c ON t.customer_id = c.customer_id
GROUP BY c.name                                 -- Group by customer
ORDER BY total_spent DESC;                     -- Highest spenders first

-- CUME_DIST()
SELECT 
    c.name AS customer,
    SUM(t.amount) AS total_revenue, --calculates total revenue per customer
    CUME_DIST() OVER (ORDER BY SUM(t.amount) DESC) --ranks customers based on total revenue as a proportion of the dataset
    AS revenue_cume_dist 
FROM customers c
JOIN transactions t ON c.customer_id = t.customer_id
GROUP BY c.name
ORDER BY total_revenue DESC;
