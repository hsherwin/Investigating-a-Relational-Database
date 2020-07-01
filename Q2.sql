/* First table finds all Family Movies and how many times they've been rented */
WITH T1 as (SELECT  f.title AS title,
	c.name AS category,
	COUNT(*) AS times_rented

FROM film f
	JOIN inventory i
	ON f.film_id = i.film_id
	JOIN rental r
	ON i.inventory_id = r.inventory_id
	JOIN film_category fc
	ON  fc.film_id = f.film_id
	JOIN category c
	ON c.category_id = fc.category_id

WHERE c.name = 'Animation' OR c.name = 'Children' OR c.name = 'Classics'
OR c.name = 'Comedy' OR c.name = 'Family' OR c.name = 'Music'

	GROUP BY 1, 2
        ORDER BY 2, 1),


/* Second table places all movies within a quartile based off of rental duration */
T2 AS   (SELECT title, 
	rental_duration,
        NTILE(4) OVER(ORDER BY rental_duration) AS Quartile  
FROM film)


/* Join t1 and t2 only for the movies with the family category to see what quartile they are in */
SELECT  T1.title, 
	T1.category, 
	T2.rental_duration,
	T2.quartile
FROM T1
JOIN T2
ON T1.title = T2.title
ORDER BY 4;