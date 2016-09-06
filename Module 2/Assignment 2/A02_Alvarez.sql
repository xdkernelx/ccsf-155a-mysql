/* Nestor Alvarez */

\W    /* enable warnings! */

use vets;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select stf_name_first, stf_name_last, stf_job_title 
From vt_staff;

/*  TASK 02 */
Select an_id AS "ID"
, an_name AS "Name"
, an_type AS "Animal Type"
, an_dob AS "Birth Date"
From vt_animals 
ORDER BY an_dob;

/*  TASK 03 */
Select DISTINCT an_type 
From vt_animals;

/*  TASK 04 */
Select srv_type, srv_desc 
From vt_services 
ORDER BY srv_type, srv_list_price;

/*  TASK 05 */
Select ex_id AS "Exam_ID"
, srv_id AS "Service"
, ex_fee AS "Fee_Charged" 
From vt_exam_details 
ORDER BY ex_id, ex_fee;

/*  TASK 06 */
Select DISTINCT an_name, an_type, an_dob 
From vt_animals 
ORDER BY an_type, an_name;

/*  TASK 07 */
Select an_id AS "Animal"
, ex_date AS "Exam Date"
, stf_id AS "Staff" 
From vt_exam_headers 
ORDER BY stf_id, ex_date;

/*  TASK 08 */
Select DISTINCT cl_state, cl_city 
From vt_clients 
ORDER BY cl_state, cl_city;