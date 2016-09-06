/* Nestor Alvarez */

\W    /* enable warnings! */

use vets;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select cl_id, cl_name_last, COALESCE(cl_name_first, '') AS 'cl_name_first', 
	COALESCE(cl_phone, 'no phone number') AS 'cl_phone' 
From vets.vt_clients;	

/*  TASK 02 */
Select concat_ws(' ', cl_id, IF(cl_name_first IS NULL, concat(cl_name_last, ':'), concat(cl_name_last, ', ', cl_name_first, ':')), 
	IF(cl_phone IS NULL, 'No phone', concat('Phone: ', cl_phone))) AS 'Client' 
From vets.vt_clients;

/*  TASK 03 */
Select srv_id, srv_list_price, Format(Round(srv_list_price, -1), 2) AS RoundedToTens, Format(Round(srv_list_price, 0), 2) AS RoundedUpToDollar 
From vets.vt_services 
WHERE srv_id BETWEEN 500 and 599;

/*  TASK 04 */
Select srv_desc 
From vets.vt_services 
WHERE srv_desc RegExp 'dental' 
AND !(srv_desc RegExp 'feline');

/*  TASK 05 */
Select ex_id, ex_date AS ExamDate1, Date(ex_date) AS ExamDate2, 
	cast(ex_date AS date) AS ExamDate3, Date_Format(ex_date, '%M %e, %Y') AS ExamDate4 
From vets.vt_exam_headers 
LIMIT 5;

/*  TASK 06 */
Select an_id, an_name 
From vets.vt_animals 
JOIN vets.vt_exam_headers USING (an_id) 
WHERE ex_date BETWEEN cast('2015-01-01' AS datetime) and date_add('2015-01-01', interval 6 month);

/*  TASK 07 */
Select an_id, an_name 
From vets.vt_animals 
JOIN vets.vt_exam_headers USING (an_id) 
WHERE EXTRACT(Month FROM ex_date) = EXTRACT(Month FROM current_date()) - 1 
 OR EXTRACT(Month FROM ex_date) = EXTRACT(Month FROM current_date());

/*  TASK 08 */
Select an_id, an_name 
From vets.vt_animals 
JOIN vets.vt_exam_headers USING (an_id) 
WHERE cast(ex_date AS date) = last_day(ex_date);

/*  TASK 09 */
Set @v = Floor(Rand() * (150-75+1) + 75);
Select @v;
Select ex_id, srv_id, ex_fee 
From vets.vt_exam_details 
WHERE ex_fee > @v;

/*  TASK 10 */
Select an_id, an_type,
	CASE 
		WHEN an_type IN ('capybara', 'dormouse', 'hamster', 'porcupine') THEN 'Rodent' 
        WHEN an_type IN ('crocodilian', 'lizard', 'snake', 'turtle') THEN 'Reptile' 
        WHEN an_type IN ('dog', 'cat') THEN 'Cat/Dog' 
        WHEN an_type IS NULL THEN 'Error' 
	ELSE an_type 
    END AS Category 
From vets.vt_animals;


