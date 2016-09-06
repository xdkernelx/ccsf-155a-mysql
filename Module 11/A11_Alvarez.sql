/* Nestor Alvarez */

\W    /* enable warnings! */

use bkorders;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select CS.cust_id, cust_name_last
, (Select count(order_id) 
	From bkorders.order_headers OH 
    WHERE OH.cust_id = CS.cust_id) AS `number of orders` 
From bkorders.customers CS 
WHERE CS.cust_id IN 
  (
	Select cust_id 
    From bkorders.customers CS 
    WHERE cust_state IN ('NJ', 'MA')
  )
GROUP BY CS.cust_id 
ORDER BY CS.cust_id;

/*  TASK 02 */
Select DISTINCT 
	(Select book_id 
     From bkinfo.books BK 
     WHERE OD.book_id = BK.book_id) AS `book_id` 
, 	(Select title 
	 From bkinfo.books BK 
     WHERE OD.book_id = BK.book_id) AS `title` 
From bkorders.order_details OD 
WHERE book_id IN 
  (
	Select book_id 
    From bkinfo.books BK 
    WHERE list_price >
      (
		Select avg(list_price) * 2 
		From bkinfo.books 
      )
  );

/*  TASK 03 */
Select sum(CASE WHEN QUARTER(order_date) = 1 THEN 1 ELSE 0 END) AS Qrt1
, sum(CASE WHEN QUARTER(order_date) = 2 THEN 1 ELSE 0 END) AS Qrt2
, sum(CASE WHEN QUARTER(order_date) = 3 THEN 1 ELSE 0 END) AS Qrt3
, sum(CASE WHEN QUARTER(order_date) = 4 THEN 1 ELSE 0 END) AS Qrt4
, count(*) AS AllQuarters 
From bkorders.order_headers OH 
WHERE YEAR(order_date) = YEAR(current_date) - 1;

/*  TASK 04 */
Select DISTINCT cust_id, cust_name_last 
FROM bkorders.customers CS 
WHERE EXISTS 
  (
	Select cust_id 
    From bkorders.order_headers OH 
    WHERE MONTH(order_date) = 1 AND YEAR(order_date) = YEAR(current_date) AND cust_id IN 
	  (
		Select cust_id 
		From bkorders.order_headers OH 
		WHERE MONTH(order_date) = 2 AND YEAR(order_date) = YEAR(current_date) AND cust_id IN 
		(
			Select cust_id 
			From bkorders.order_headers OH 
			WHERE MONTH(order_date) = 3 AND YEAR(order_date) = YEAR(current_date) 
            AND CS.cust_id = OH.cust_id
		)
	  )
  )
  ORDER BY cust_id;

/*  TASK 05 */
Select author_name_first, author_name_last, AR.author_id 
From bkinfo.authors AR 
WHERE EXISTS 
  (
	Select author_id 
	From bkinfo.book_authors BA 
	WHERE AR.author_id = BA.author_id 
      AND book_id IN
      (
		Select book_id 
        From bkinfo.books BK
        WHERE book_id NOT IN  
          (
			Select BK.book_id 
            From bkorders.order_details OD
            WHERE BK.book_id = OD.book_id 
          )
      )
  )
  ORDER BY AR.author_id;


/*  TASK 06 */
Select book_id, title 
From bkinfo.books BK 
WHERE book_id IN  
  (
	Select book_id 
	From bkinfo.book_topics BT
	WHERE BT.book_id = BK.book_id AND 
	  topic_id IN ('SSRV', 'ORA', 'MySQL') 
	GROUP BY book_id 
    HAVING count(book_id) = 2
  );

/*  TASK 07 */
Select order_date, order_id
, (Select cust_id 
   From bkorders.customers CS 
   WHERE CS.cust_id = OH.cust_id
  ) AS `cust_id` 
, (Select cust_name_last 
   From bkorders.customers CS 
   WHERE CS.cust_id = OH.cust_id
  ) AS `Customer`
, Coalesce((Select sum(quantity) 
   From bkorders.order_details OD 
   WHERE OD.order_id = OH.order_id
  ), 0) AS `NumberBooks` 
, Coalesce((Select sum(order_price) 
   From bkorders.order_details OD 
   WHERE OD.order_id = OH.order_id
  ), 0) AS `OrderCost` 
From bkorders.order_headers OH 
WHERE MONTH(order_date) IN (1, 2, 3) AND YEAR(order_date) = YEAR(current_date) - 1 
ORDER BY order_date;

/*  TASK 08 */
Select cust_id
, (Select cust_name_last 
   From bkorders.customers CS 
   WHERE CS.cust_id = OH.cust_id
  ) AS `Customer` 
From bkorders.order_headers OH 
WHERE YEAR(order_date) = YEAR(current_date) - 1 AND QUARTER(order_date) IN (1, 2, 3) 
GROUP BY cust_id 
HAVING count(cust_id) BETWEEN 3 AND 5 
ORDER BY cust_id;

/*  TASK 09 */
Select cust_id
, (Select cust_name_last 
   From bkorders.customers CS
   WHERE CS.cust_id = OH.cust_id) AS `Customer` 
From bkorders.order_headers OH 
WHERE YEAR(order_date) = YEAR(current_date) - 1 
GROUP BY cust_id 
HAVING count(cust_id) >= ALL 
  (
	Select count(cust_id) 
    From bkorders.order_headers OH 
    WHERE YEAR(order_date) = YEAR(current_date) - 1 
    GROUP BY cust_id
  );

/*  TASK 10 */
Select cust_id 
, (Select cust_name_last 
   From bkorders.customers CS 
   WHERE CS.cust_id = OH.cust_id 
   ) AS `Customer` 
From bkorders.order_headers OH 
WHERE YEAR(order_date) = YEAR(current_date) - 1 
 AND QUARTER(order_date) = 1 
GROUP BY cust_id 
HAVING count(order_id) >= 
  (
	Select count(order_id) 
    From bkorders.order_headers 
	WHERE YEAR(order_date) = YEAR(current_date) 
	 AND QUARTER(order_date) = 1 
     AND cust_id = OH.cust_id
  )
ORDER BY cust_id;

