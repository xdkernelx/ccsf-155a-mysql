/* Nestor Alvarez */

\W    /* enable warnings! */

use bkorders;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select order_date AS OrderDate, count(order_id) AS NumberOrders, sum(quantity * order_price) AS AmntDue, sum(quantity) AS NumbBooksPurch 
From bkorders.order_headers 
JOIN bkorders.order_details USING (order_id) 
WHERE YEAR(order_date) = 2016 
GROUP BY order_date;

/*  TASK 02 */
Select (CASE WHEN `Year` IS NULL THEN 'Grand Total' ELSE lpad(`Year`, 11, ' ') END) AS `Year` 
	,  (CASE WHEN `Year` IS NULL THEN '..........' 
			 WHEN `Month` IS NULL THEN 'Year Total' ELSE lpad(`Month`, 10, ' ') END) AS `Month` 
    ,  (CASE WHEN `Year` IS NULL THEN '...........' 
			 WHEN `Month` IS NULL THEN '...........' 
             WHEN ORDER_ID IS NULL THEN 'Month Total' ELSE lpad(ORDER_ID, 11, ' ') END) AS ORDER_ID
	, AmntDue, NumbBooksPurch 
From (
	Select YEAR(order_date) AS `Year`, Month(order_date) AS `Month`, order_id AS ORDER_ID, sum(order_price * quantity) AS AmntDue, sum(quantity) AS NumbBooksPurch 
	From bkorders.order_headers 
	JOIN bkorders.order_details USING (order_id) 
	WHERE order_date BETWEEN '2015-11-01' and '2016-02-29' 
	GROUP BY `Year`, `Month`, order_id WITH ROLLUP	
     ) ROLLED;

/*  TASK 03 */
Select (CASE WHEN `Year` IS NULL THEN 'Grand Total' ELSE lpad(`Year`, 11, ' ') END) AS `Year` 
	,  'Yearly Total'  
    ,  NumberOrders 
	, AmntDue, NumbBooksPurch 
From (
	Select YEAR(order_date) AS `Year`, count(order_id) AS NumberOrders, sum(order_price * quantity) AS AmntDue, sum(quantity) AS NumbBooksPurch 
	From bkorders.order_headers 
	JOIN bkorders.order_details USING (order_id) 
	GROUP BY `Year` WITH ROLLUP	
     ) ROLLED;

/*  TASK 04 */
Select (CASE WHEN AuthorID IS NULL THEN 'All Authors' ELSE AuthorID END) AS AuthorID 
,  (CASE WHEN BookID IS NULL THEN 'All Books' ELSE BookID END) AS BookID, TotalQuantity 
,  (CASE WHEN TotalSales IS NULL THEN 'No Sales' ELSE TotalSales END) AS TotalSales 
From (
	Select author_id AS AuthorID, BK.book_id AS BookID, count(order_id) AS TotalQuantity, sum(order_price * quantity) AS TotalSales  
	From bkinfo.books BK 
	JOIN bkinfo.book_authors USING (book_id) 
	LEFT JOIN bkorders.order_details OD ON BK.book_id = OD.book_id 
	WHERE author_sequence = 1 
	GROUP BY author_id, BK.book_id WITH ROLLUP
     ) SALES;

/*  TASK 05 */
Select book_id AS Book_ID, page_count AS Page_count, 
	 (
	Select count(distinct BK2.page_count DIV 150) 
    From bkinfo.books BK2 
    WHERE BK2.page_count DIV 150 >= BK1.page_count DIV 150 
		AND BK2.book_id <= 1500
	 ) Rank 
From bkinfo.books BK1 
WHERE book_id NOT IN 
  (
	Select book_id 
    From bkinfo.books 
    WHERE page_count IS NULL
  ) AND book_id <= 1500 
GROUP BY book_id 
ORDER BY Rank, page_count DESC;

/*  TASK 06 */
Select adddate('2015-03-01', numvalue) AS order_date, sum(quantity) AS QuantityOrdered, sum(quantity * order_price) AS TotalSales 
from 
( 
	select b1.val + b2.val + b4.val + b8.val + b16.val + b32.val as numvalue 
	from 
		( select 0 val union all select 1) b1 cross join 
		( select 0 val union all select 2) b2 cross join 
		( select 0 val union all select 4) b4 cross join 
		( select 0 val union all select 8) b8 cross join 
		( select 0 val union all select 16) b16 cross join 
		( select 0 val union all select 32) b32
) AS GENNUM 
RIGHT JOIN bkorders.order_headers OH ON OH.order_date = adddate('2015-03-01', numvalue) 
RIGHT JOIN bkorders.order_details OD USING (order_id) 
WHERE adddate('2015-03-01', numvalue) <= '2015-03-31' OR quantity IS NULL 
GROUP BY order_date;