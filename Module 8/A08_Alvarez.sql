/* Nestor Alvarez */

\W    /* enable warnings! */

use bkinfo;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
drop view if exists bkorders.BkOrdersPriorYear;
create view bkorders.BkOrdersPriorYear AS (
	Select DISTINCT CS.cust_id AS customerID
    , concat(CS.cust_name_last, IF(CS.cust_name_first IS NULL, "", concat(", ", CS.cust_name_first))) AS customerName
    , cast(OH.order_date as date) AS order_date 
    From bkorders.customers CS
    JOIN bkorders.order_headers OH USING (cust_id) 
    JOIN bkorders.order_details OD USING (order_id) 
    WHERE YEAR(order_date) = 2015
);

/*  TASK 02 */
Select DISTINCT customerID, customerName 
From bkorders.BkOrdersPriorYear 
WHERE MONTH(order_date) IN (4, 6, 8);

/*  TASK 03 */
Select DISTINCT customerID, customerName 
From bkorders.BkOrdersPriorYear 
WHERE customerID NOT IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE MONTH(order_date) IN (3, 6, 9)
 );

/*  TASK 04 */
Select DISTINCT customerID, customerName 
From bkorders.BkOrdersPriorYear 
WHERE customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 3
 ) AND customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 6
 ) AND customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 9
 );

/*  TASK 05 */
Select DISTINCT customerID, customerName 
From bkorders.BkOrdersPriorYear 
WHERE customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 1
 ) AND customerID NOT IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear
    WHERE Month(order_date) IN (2, 3)
 );

/*  TASK 06 */
Select DISTINCT customerID, customerName 
From bkorders.BkOrdersPriorYear 
WHERE customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 3
 ) AND customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear
    WHERE Month(order_date) IN (4, 5)
 );

/*  TASK 07 */
Select DISTINCT customerID, customerName 
From bkorders.BkOrdersPriorYear 
WHERE customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 4
 ) AND customerID IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 5
 ) AND customerID NOT IN 
 (
	Select customerID 
    From bkorders.BkOrdersPriorYear 
    WHERE Month(order_date) = 6
 );