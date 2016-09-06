/* Nestor Alvarez */

\W    /* enable warnings! */

use bkorders;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select sum(order_price * quantity) AS AmtDue 
From bkorders.order_details 
WHERE book_id = 1108;

/*  TASK 02 */
Select count(*) AS NumberOfOrders 
From bkorders.order_details 
WHERE book_id = 1108 AND order_id IN 
  (
	Select order_id 
    From bkorders.order_details 
    JOIN bkorders.order_headers USING (order_id) 
    WHERE YEAR(order_date) = YEAR(date_sub(current_date, interval 1 year))
  );

/*  TASK 03 */
Select cust_id AS CustID, cust_name_last AS CustName, count(*) AS BookTotal
 , count(case when YEAR(order_date) = YEAR(current_date) then 1 else null end) AS CurrentYearBookTotal 
From bkorders.customers 
JOIN bkorders.order_headers USING (cust_id) 
GROUP BY cust_id;

/*  TASK 04 */
Select count(*) AS PrevYearTotalOrders, count(distinct cust_id) AS CustomerCount 
From bkorders.customers 
JOIN bkorders.order_headers USING (cust_id) 
WHERE YEAR(order_date) = YEAR(date_sub(current_date, interval 1 quarter)) 
	AND QUARTER(order_date) = QUARTER(date_sub(current_date, interval 1 quarter));

/*  TASK 05 */
Select BK.book_id, title 
From bkinfo.books BK 
JOIN bkorders.order_details OD USING (book_id) 
WHERE book_id IN 
  (
	Select book_id 
    From bkinfo.book_topics 
    JOIN bkinfo.books USING (book_id) 
    WHERE topic_id IN ('NOSQL', 'XML', 'DB')
  )
GROUP BY BK.book_id 
HAVING count(*) = 42;

/*  TASK 06 */
Select sum(case when topic_id = 'SCI' then 1 else 0 end) AS Science
, sum(case when topic_id = 'DB' then 1 when topic_id = 'SQL' then 1 when topic_id = 'SSRV' then 1 
			when topic_id = 'MySQL' then 1 when topic_id = 'ORA' then 1 when topic_id = 'ADO' then 1 else 0 end) AS 'Database System'
, sum(case when topic_id = 'NOSQL' then 1 when topic_id = 'XML' then 1 when topic_id = 'DB' then 1 else 0 end) AS 'Data Storage Techniques'
, sum(case when topic_id IS NOT NULL then 1 else 0 end) AS 'All Books' 
From bkinfo.book_topics BT 
JOIN bkinfo.books BK USING (book_id);

/*  TASK 07 */
Select CS.cust_id as CustID, cust_name_last AS CustName, max(order_date) AS MostRecentOrder 
From bkorders.customers CS 
JOIN bkorders.order_headers OH USING (cust_id) 
JOIN bkorders.order_details OD USING (order_id) 
GROUP BY CS.cust_id;

/*  TASK 08 */
Select CS.cust_id as CustID, cust_name_last AS CustName, sum(quantity * order_price)  
From bkorders.customers CS 
JOIN bkorders.order_headers OH USING (cust_id) 
JOIN bkorders.order_details OD USING (order_id) 
WHERE book_id IN 
    (
		Select book_id 
        From bkinfo.book_topics 
        WHERE topic_id IN ('SQL') AND book_id != 1142
    )
GROUP BY CS.cust_id 
HAVING sum(quantity * order_price) > 500.00;

