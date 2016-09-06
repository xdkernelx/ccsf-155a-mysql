/* Nestor Alvarez */

\W    /* enable warnings! */

use vets;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select CL.cl_id, cl_name_last 
From vets.vt_clients CL 
LEFT JOIN vets.vt_animals AN ON CL.cl_id = AN.cl_id 
WHERE an_id IS NULL;

/*  TASK 02 */
Select cl_id, cl_name_last 
From vets.vt_clients 
WHERE cl_id NOT IN 
 (
   Select cl_id 
   From vets.vt_animals 
 );

/*  TASK 03 */
Select cl_id, cl_name_last 
From vets.vt_clients 
WHERE cl_id NOT IN 
 (
   Select cl_id 
   From vets.vt_animals 
   WHERE an_type IN ('crocodilian', 'lizard', 'snake', 'turtle')
 );

/*  TASK 04 */
Select CL.cl_id, cl_name_last,  
	CASE 
		WHEN an_type IS NULL THEN 'no animals' 
		WHEN an_name IS NULL THEN 'no name' 
	ELSE an_name 
    END AS 'an_name', 
    CASE 
		WHEN an_type IS NULL THEN 'no animals' 
	ELSE an_type 
    END AS 'an_type'
From vets.vt_clients CL 
LEFT JOIN vets.vt_animals AN ON CL.cl_id = AN.cl_id;

/*  TASK 05 */
Select CL.cl_id, cl_name_last, AN.an_id, an_type 
From vets.vt_clients CL 
LEFT JOIN vets.vt_animals AN ON CL.cl_id = AN.cl_id 
LEFT JOIN vets.vt_exam_headers EH ON AN.an_id = EH.an_id 
WHERE EH.ex_id IS NULL AND AN.an_id IS NOT NULL 
ORDER BY CL.cl_id, AN.an_id;

/*  TASK 06 */
Select CL.cl_id, cl_name_last, AN.an_id, an_type 
From vets.vt_clients CL 
LEFT JOIN vets.vt_animals AN ON CL.cl_id = AN.cl_id 
LEFT JOIN vets.vt_exam_headers EH ON AN.an_id = EH.an_id 
WHERE EH.ex_id IS NULL 
ORDER BY CL.cl_id, AN.an_id;

/*  TASK 07 */
Select CL.cl_id, cl_name_last, AN.an_id, an_type, an_dob 
From vets.vt_clients CL 
JOIN vets.vt_animals AN USING (cl_id) 
WHERE cl_state IN ('NY', 'MA') 
	AND an_type NOT IN ('cat', 'dog', 'bird');

/*  TASK 08 */
Select an_id, an_name 
From vets.vt_animals 
JOIN vets.vt_exam_headers USING (an_id) 
WHERE EXTRACT(Year FROM ex_date) = EXTRACT(Year FROM current_date);

/*  TASK 09 */
Select SRV.srv_id, srv_list_price, srv_desc, srv_type 
From vets.vt_exam_details ED
RIGHT JOIN vets.vt_services SRV ON ED.srv_id = SRV.srv_id 
WHERE ex_id IS NULL AND srv_list_price > 100.00;
