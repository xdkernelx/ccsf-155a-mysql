/* Nestor Alvarez */

\W    /* enable warnings! */

use a_testbed;

/*  TASK 00 */ 
select user(), current_date(), version(), @@sql_mode\G

/*  TASK 01 */
Select id, extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
From xml_a13_animals 
ORDER BY `ClientID`;

/*  TASK 02 */
Select id, extractValue(an_data, '//an_id') AS AnimalID
, extractValue(an_data, '//an_type') AS TypeOfAnimal
, extractValue(an_data, '//an_name') AS `Name`
, extractValue(an_data, '//an_price') AS Price 
From xml_a13_animals 
ORDER BY 
	cast(
		CASE WHEN extractValue(an_data, '/descendant-or-self::an_id[1]') = '' THEN 0 ELSE extractValue(an_data, '/descendant-or-self::an_id[1]') END
    AS UNSIGNED);

/*  TASK 03 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
From xml_a13_animals 
WHERE extractValue(an_data,'COUNT(//animal[an_type = "cat"])') > 0;

/*  TASK 04 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
, extractValue(an_data, 'COUNT(//an_id)') AS NumberOfAnimals 
From xml_a13_animals 
ORDER BY `NumberOfAnimals` DESC;

/*  TASK 05 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
, CASE WHEN extractValue(an_data, '//an_name') = '' THEN 'This client has no animals' 
	   ELSE concat(
			extractValue(an_data, '/descendant-or-self::an_type[1]')
            , ' named ', extractValue(an_data, '/descendant-or-self::an_name[1]')) END AS Animal_First  
From xml_a13_animals;

/*  TASK 06 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
, concat(
	extractValue(an_data, '/descendant-or-self::an_type[1]')
	, ' named ', extractValue(an_data, '//animal[1]/child::an_name[last()]')) AS Animal_First  
From xml_a13_animals 
WHERE extractValue(an_data, '/descendant-or-self::an_type[1]') != '';

/*  TASK 07 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
From xml_a13_animals 
WHERE extractValue(an_data, '/descendant-or-self::an_id[last()]') != extractValue(an_data, '/descendant-or-self::an_id[1]') 
	AND (
		extractValue(an_data, '/descendant-or-self::an_id[last()-1]') = extractValue(an_data, '/descendant-or-self::an_id[1]') 
     OR extractValue(an_data, '/descendant-or-self::an_id[last()-1]') = extractValue(an_data, '/descendant-or-self::an_id[2]') 
    );

/*  TASK 08 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
From xml_a13_animals 
WHERE extractValue(an_data,'COUNT(//animal[an_type = "bird" AND an_price = "250"])') > 0;

/*  TASK 09 */
Select extractValue(an_data, '//cl_name') AS `Client` 
, cast(extractValue(an_data, 'client/@cl_id') AS UNSIGNED) AS ClientID 
From xml_a13_animals 
WHERE extractValue(an_data,'COUNT(//animal[an_type = "bird" AND an_price = "250"])') > 0
	AND extractValue(an_data,'COUNT(//animal[an_type = "cat"])') > 1;

