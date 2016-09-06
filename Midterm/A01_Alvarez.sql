/* Nestor Alvarez */

\W    /* enable warnings! */

use   a_testbed;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
delete
from a_testbed.zoo_2016
where z_id > 100;

select *
from a_testbed.zoo_2016;

/*  TASK 02 */
insert into a_testbed.zoo_2016 (z_id, z_name, z_type, z_cost, z_dob, z_acquired) values
(101, 'Alfy', 'Roadrunner', 1337.00, current_date(), current_date()),
(101, 'Kia',  'Koala',         0.99, current_date(), current_date()),
(101, 'Brie', 'Cow',         600.00, current_date(), current_date())
;

/*  TASK 03 */
/* From Insight, From Joanne Cho */
Insert Into a_testbed.zoo_2016  (z_id, z_name, z_type, z_cost, z_dob, z_acquired)   Values

   (111,'Lizzy','Bear', 5000.00, '2016-01-15','2016-01-26');

Insert Into a_testbed.zoo_2016 (z_id, z_name, z_type, z_cost, z_dob, z_acquired)    Values 

   (122, 'Fil', 'Snake', 490.00, '2013-01-15', '2013-04-05');

Insert Into a_testbed.zoo_2016 (z_id, z_name, z_type, z_cost, z_dob, z_acquired)    Values 

   (133, 'Mary', 'Rat', 5000.00, '2011-02-24', '2011-03-28');
/* From Insight, From Rebecca Kaufan */
Insert into zoo_2016 

(z_id, z_name, z_type, z_cost, z_dob, z_acquired)

Values (110, 'Ozzy', 'Majestic Cat', 25.00, '2010-03-15', '2010-04-15'),

(111, 'Smooshie', 'Regular Cat', 30.00, '2010-02-10', '2010-03-15'),

(112, 'Squishy', 'Yard Squirrel', 0.00, '2015-06-15', '2015-08-15'); 

/* From Insight, From Nishtman Vosoughi */

Insert Into  a_testbed.zoo_2016  (z_id, z_name, z_type, z_cost, z_dob, z_acquired)    Values
   (152, 'Ram', 'Cheetah', 1500.00, '2012-06-10', '2013-01-08');
Insert Into  a_testbed.zoo_2016  (z_id, z_name, z_type, z_cost, z_dob, z_acquired)    Values
   (183, 'Survivor', 'Coyote', 400.00, '2010-02-15', '2015-05-21');
Insert Into  a_testbed.zoo_2016  (z_id, z_name, z_type, z_cost, z_dob, z_acquired)    Values
   (352, 'Snow', 'Panda', 95000.00, '2009-09-23', '2011-04-21');

/*  TASK 04 */
select z_id, z_name, z_type, z_cost, z_dob, z_acquired
from a_testbed.zoo_2016;

/*  TASK 05 */
select z_type, z_name, z_cost 
from zoo_2016 
order by z_type, z_name;

/*  TASK 06 */
select z_id, z_name, z_dob 
from zoo_2016 
where z_type = 'Zebra' 
order by z_dob;

/*  TASK 07 */
show tables;

/*  TASK 08 */
desc a_testbed.zoo_2016;

/*  TASK 09 */
show variables like 'char%';

/*  TASK 10 */
