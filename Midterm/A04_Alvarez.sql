/* Nestor Alvarez */

\W    /* enable warnings! */

use vets;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select cl_id, an_id, an_type, an_name 
From vets.vt_animals 
WHERE an_dob < '2010-01-01';

/*  TASK 02 */
Select ED.ex_id, ex_date, srv_id, ex_fee  
From vets.vt_animals 
JOIN vets.vt_exam_headers USING ( an_id ) 
JOIN vets.vt_exam_details ED USING ( ex_id )  
WHERE an_type IN ('capybara', 'dormouse', 'hamster', 'porcupine') 
ORDER BY ex_id, srv_id;


/*  TASK 03 */
Select ST.stf_id, concat(stf_name_first, ' ', stf_name_last) AS staff, ex_date 
From vets.vt_animals 
JOIN vets.vt_exam_headers EH USING ( an_id ) 
JOIN vets.vt_staff ST USING ( stf_id ) 
WHERE an_type NOT IN ('crocodilian', 'lizard', 'snake', 'turtle', 'bird') 
ORDER BY ex_date;

/*  TASK 04 */
Select cl_id, EH.ex_id, ex_date, srv_id, ex_fee  
From vets.vt_clients 
JOIN vets.vt_animals USING ( cl_id ) 
JOIN vets.vt_exam_headers EH USING ( an_id )
JOIN vets.vt_exam_details ED USING ( ex_id ) 
WHERE ex_fee NOT BETWEEN 25 and 200 
ORDER BY ex_date, srv_id;

/*  TASK 05 */
Select srv_id, srv_list_price, srv_desc, srv_type 
From vets.vt_services 
WHERE srv_desc LIKE "%Feline%" 
AND srv_desc NOT LIKE "%Dental%" 
ORDER BY srv_type, srv_id;

/*  TASK 06 */
Select DISTINCT cl_id, cl_name_last 
From vets.vt_clients 
JOIN vets.vt_animals USING ( cl_id ) 
WHERE an_type = 'dog' 
ORDER BY cl_id;

/*  TASK 07 */
Select DISTINCT cl_id, cl_name_last 
From vets.vt_clients 
JOIN vets.vt_animals USING ( cl_id ) 
WHERE an_type NOT IN ('dog') 
ORDER BY cl_id;

/*  TASK 08 */
Select DISTINCT cl_id, cl_name_last 
From vets.vt_clients 
JOIN vets.vt_animals USING ( cl_id ) 
WHERE an_type IN ('capybara', 'dormouse', 'hamster', 'porcupine') 
ORDER BY cl_id;

/*  TASK 09 */
Select DISTINCT cl_id, cl_name_last 
From vets.vt_clients 
JOIN vets.vt_animals USING ( cl_id ) 
WHERE an_type NOT IN ('capybara', 'dormouse', 'hamster', 'porcupine') 
ORDER BY cl_id;
