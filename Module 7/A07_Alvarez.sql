/* Nestor Alvarez */

\W    /* enable warnings! */

use vets;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select CL.cl_id, cl_name_last, an_id, an_type, an_name 
From vets.vt_clients CL 
JOIN vets.vt_animals USING (cl_id);

/*  TASK 02 */
Select AN.an_id, an_type, an_name, EH.ex_id, EXTRACT(Year from ex_date) as ex_year, srv_id 
From vets.vt_animals AN 
JOIN vets.vt_exam_headers EH USING (an_id) 
JOIN vets.vt_exam_details USING (ex_id);

/*  TASK 03 */
Select cl_id, cl_name_last 
From vets.vt_clients 
WHERE cl_id IN 
 (
	Select CL.cl_id 
    From vets.vt_clients CL
    JOIN vets.vt_animals USING (cl_id) 
    WHERE an_type NOT IN ('crocodilian', 'lizard', 'snake', 'turtle')
 );

/*  TASK 04 */
Select cl_id, cl_name_last 
From vets.vt_clients 
WHERE cl_id IN 
 (
	Select CL.cl_id 
    From vets.vt_clients CL
    JOIN vets.vt_animals USING (cl_id) 
    WHERE an_type IN ('crocodilian', 'lizard', 'snake', 'turtle')
 ) AND cl_id IN
 (
	Select CL.cl_id 
    From vets.vt_clients CL
    JOIN vets.vt_animals USING (cl_id) 
    WHERE an_type = 'dog'
 );

/*  TASK 05 */

Select cl_id, cl_name_last 
From vets.vt_clients 
WHERE cl_id IN 
 (
	Select CL.cl_id 
    From vets.vt_clients CL
    JOIN vets.vt_animals USING (cl_id) 
    WHERE an_type IN ('crocodilian', 'lizard', 'snake', 'turtle')
 ) AND cl_id NOT IN
 (
	Select CL.cl_id 
    From vets.vt_clients CL
    JOIN vets.vt_animals USING (cl_id) 
    WHERE an_type = 'dog'
 );

/*  TASK 06 */
Select DISTINCT AN.an_id, an_name 
From vets.vt_animals AN 
JOIN vets.vt_exam_headers EH USING (an_id) 
JOIN vets.vt_exam_details USING (ex_id)
WHERE an_id NOT IN 
 (
	Select AN.an_id 
    From vets.vt_animals AN 
	JOIN vets.vt_exam_headers EH USING (an_id) 
	JOIN vets.vt_exam_details USING (ex_id)
    WHERE srv_id IN (104, 105, 106, 108)
 );

/*  TASK 07 */
Select DISTINCT AN.an_id, an_name, an_type, CL.cl_id 
From vets.vt_clients CL 
JOIN vets.vt_animals AN USING (cl_id) 
JOIN vets.vt_exam_headers USING (an_id) 
WHERE CL.cl_id IN 
 (
	Select CL.cl_id 
    From vets.vt_clients CL
	JOIN vets.vt_animals AN USING (cl_id) 
	JOIN vets.vt_exam_headers USING (an_id) 
    WHERE EXTRACT(Year from ex_date) = 2015
 ) AND CL.cl_id IN 
 (
	Select CL.cl_id 
    From vets.vt_clients CL
	JOIN vets.vt_animals AN USING (cl_id) 
	JOIN vets.vt_exam_headers USING (an_id) 
    WHERE EXTRACT(Year from ex_date) = 2016
 );

/*  TASK 08 */
Select AN.an_id, an_name, an_type, CL.cl_id 
From vets.vt_clients CL 
JOIN vets.vt_animals AN USING (cl_id) 
WHERE an_type IN ('crocodilian', 'lizard', 'snake', 'turtle') 
	AND AN.an_id IN 
     (
		Select AN.an_id 
		From vets.vt_clients CL 
		JOIN vets.vt_animals AN USING (cl_id) 
        JOIN vets.vt_exam_headers USING (an_id) 
        WHERE EXTRACT(Year from ex_date) = EXTRACT(Year from date_sub(current_date, interval 1 year))
     ) AND AN.an_id NOT IN 
     (
		Select AN.an_id 
		From vets.vt_clients CL 
		JOIN vets.vt_animals AN USING (cl_id) 
        JOIN vets.vt_exam_headers USING (an_id) 
        WHERE EXTRACT(Year from ex_date) = EXTRACT(Year from current_date)
     );
