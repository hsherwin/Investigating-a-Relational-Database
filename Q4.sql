/* First table finds top 10 customers */
WITH t1 AS
(SELECT c.first_name||' '|| c.last_name AS customer_name,
	c.customer_id AS customer_id,
	SUM(p.amount) AS total_payment,
	COUNT(*) AS paycount
 
FROM 	customer c
JOIN 	payment p
ON 	p.customer_id = c.customer_id

GROUP BY 1, 2
ORDER BY total_payment DESC
LIMIT 10),

/* Second table finds monthly transaction history of all customers */
t2 AS 
(SELECT  c.first_name||' '|| c.last_name AS customer_name,
	c.customer_id AS customer_id,
	DATE_TRUNC('MONTH', p.payment_date) AS month,
	SUM(p.amount) AS total_payment,
	COUNT(*) AS paycount
    
FROM 	customer c
JOIN 	payment p
ON 	p.customer_id = c.customer_id

GROUP BY 1, 2, 3
ORDER BY 1, 3)

/* Join the tables t1 and t2 to limit for Top 10 customers */
SELECT  
	t2.month,
	t1.customer_name,
	t2.total_payment,
	t2.paycount
        
FROM 	t1
JOIN	t2
ON	t1.customer_id = t2.customer_id
AND 	t1.customer_name = t2.customer_name

/* final adaption for only March 2007 figures */
 WHERE t2.month = '2007-03-01';
