SELECT   c.name AS category,
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

	GROUP BY 1
    ORDER BY 2 DESC