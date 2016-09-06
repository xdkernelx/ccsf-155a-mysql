/* Nestor Alvarez */

\W    /* enable warnings! */

use vets;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select 
	DISTINCT concat(cl_postal_code, ': ', cl_city, ' ', cl_state) AS Location 
From vets.vt_clients 
WHERE cl_state IN ('CA', 'NV');

/*  TASK 02 */
Select cl_name_first, cl_name_last, cl_phone 
From vets.vt_clients 
WHERE cl_phone IS NOT NULL 
ORDER BY cl_id;

/*  TASK 03 */
Select DISTINCT srv_id 
From vets.vt_exam_details 
WHERE ex_fee >= 75;

/*  TASK 04 */
Select concat(stf_name_first, ' ', stf_name_last) AS staff
, stf_id
, stf_job_title 
From vets.vt_staff 
WHERE stf_job_title NOT IN ('vet', 'vet assnt');

/*  TASK 05 */
Select srv_id AS "Service ID"
, srv_type AS "Service Type"
, srv_desc AS "Description"
, srv_list_price AS "Curr Price"
, (srv_list_price * 0.15 + srv_list_price) AS "Incr Price" 
From vets.vt_services 
WHERE srv_type NOT IN ('office visit') 
ORDER BY srv_id;

/*  TASK 06 */
Select cl_id, an_id, an_name 
From vets.vt_animals 
WHERE an_type IN ('capybara', 'dormouse', 'hamster', 'porcupine') 
ORDER BY cl_id, an_id;

/*  TASK 07 */
Select DISTINCT cl_id, an_type 
From vets.vt_animals 
WHERE an_type IN ('crocodilian', 'lizard', 'snake', 'turtle') 
ORDER BY cl_id;

/*  TASK 08 */
Select cl_id, an_id, an_name, an_dob 
From vets.vt_animals 
WHERE an_type IN ('bird', 'cat', 'dog', 'hedgehog', 'olinguito') 
ORDER BY an_dob;
