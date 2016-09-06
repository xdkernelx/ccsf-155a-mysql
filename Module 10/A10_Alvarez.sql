/* Nestor Alvarez */

\W    /* enable warnings! */

use bkinfo;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select book_id, title 
From bkinfo.books 
WHERE book_id IN 
 (
	Select book_id 
    From bkinfo.book_topics 
    WHERE topic_id IN ('SQL', 'DB') 
 ) AND book_id IN 
 (
	Select book_id
    From bkorders.order_details
 )
GROUP BY book_id 
ORDER BY book_id;

/*  TASK 02 */
Select book_id, title 
From bkinfo.books 
WHERE book_id IN 
 (
	Select book_id 
    From bkinfo.book_topics 
    WHERE topic_id = 'SQL' 
     AND book_id IN 
      (
		Select book_id 
        From bkinfo.book_topics 
        WHERE topic_id = 'DB' 
      )
 ) AND book_id IN 
 (
	Select book_id
    From bkorders.order_details
 )
GROUP BY book_id 
ORDER BY book_id;

/*  TASK 03 */
Select book_id, title 
From bkinfo.books 
WHERE book_id IN 
 (
	Select book_id 
    From bkinfo.book_topics 
    WHERE topic_id = 'SQL' 
     AND book_id IN 
      (
		Select book_id 
        From bkinfo.book_topics 
        WHERE topic_id = 'DB' 
      )
 ) AND book_id NOT IN 
 (
	Select book_id
    From bkorders.order_details
 )
GROUP BY book_id 
ORDER BY book_id;

/*  TASK 04 */
Select cust_id, cust_name_last 
From bkorders.customers 
WHERE cust_id IN 
 (
	Select cust_id 
    From bkorders.order_headers 
    WHERE YEAR(order_date) = YEAR(current_date) 
     AND order_id IN 
      (
		Select order_id 
        From bkorders.order_details 
        WHERE book_id IN 
         (
			Select book_id 
            From bkinfo.book_topics 
            WHERE topic_id = 'HIST'
         )
      )
 ) 
ORDER BY cust_id;

/*  TASK 05 */
Select book_id, title 
From bkinfo.books 
WHERE book_id IN 
 (
	Select book_id 
    From bkorders.order_details 
    GROUP BY book_id 
    HAVING sum(quantity) > 500 
 )
ORDER BY book_id;

/*  TASK 06 */
Select DISTINCT MONTHNAME(order_date) AS `Month`, YEAR(order_date) AS `YEAR` 
From bkorders.order_headers 
WHERE order_date IN 
 (
	Select order_date 
    From bkorders.order_headers 
    WHERE order_id IN 
     (
		Select order_id 
        From bkorders.order_details 
        WHERE order_id IN 
         (
			Select order_id 
            From bkorders.order_details 
            GROUP BY order_id 
            HAVING sum(quantity) <= ALL 
			  (
				Select sum(quantity) 
				From bkorders.order_details 
                GROUP BY order_id 
                HAVING sum(quantity) > 0
			  )
         )
     ) 
 );

/*  TASK 07 */
Select DISTINCT MONTHNAME(order_date) AS `Month`, YEAR(order_date) AS `YEAR` 
From bkorders.order_headers 
WHERE order_date IN 
 (
	Select order_date 
    From bkorders.order_headers 
    WHERE order_id IN 
     (
		Select order_id 
        From bkorders.order_details 
        WHERE order_id IN 
         (
			Select order_id 
            From bkorders.order_details 
            GROUP BY order_id 
            HAVING sum(quantity) >= ALL 
			  (
				Select sum(quantity) 
				From bkorders.order_details 
                GROUP BY order_id 
                HAVING sum(quantity) > 0
			  )
         )
     ) 
 );

