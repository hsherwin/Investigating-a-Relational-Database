SELECT  s.store_id, 
	DATE_PART ('year', r.rental_date) AS rental_year,
	DATE_PART ('month', r.rental_date) AS rental_month,
	COUNT(*) AS count_of_rentals

FROM 	Store s
JOIN 	staff st
ON 	s.store_id = st.store_id
JOIN 	rental r
ON 	r.staff_id = st.staff_id

GROUP BY 1, 2, 3
ORDER BY 2, 3;