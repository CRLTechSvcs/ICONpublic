/* 
	- 2013-09-26
	- determining number of COUNTRIES where ICON has PUBLICATIONS for some valid issues 
	- using in ICON/javascripts/statistics_countries.js
*/


/* 
how many US states? 
	2014-01-30, pubsUSstateCountValue = 52 BUT 'xxu' IS EXTRA so subtract 1 for the public
*/
SELECT COUNT(DISTINCT country_id) AS pubsUSstateCountValue FROM publications  
/* SELECT DISTINCT country_id FROM publications # if we wanted to see exactly what they are */
WHERE (
	(pub_id IN (SELECT DISTINCT pub_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND 
	(country_id LIKE '__u')
);


/* 
	2014-08-14 
	how many publications and issues in any US jurisdiction? 
	- this result needs to be put into get_statistics_countries_static.php 
		BY HAND
*/
SELECT 
	COUNT(i.issue_id) AS numIssuesAllUSA, 
	MIN(i.issue_date) AS minUSdate, 
	MAX(i.issue_date) AS maxUSdate, 
	COUNT(DISTINCT p.pub_id) AS numPublicationsAllUSA, 
	COUNT(DISTINCT p.country_id) AS pubsUSstateCountValue 
FROM issues i 
JOIN publications p ON p.pub_id = i.pub_id 
WHERE (
	i.issue_date <> '0000-00-00'
	AND 
	(p.pub_id IN (SELECT DISTINCT i.pub_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND 
	(p.country_id LIKE '__u')
);



/* **************** */


/* 
how many Canadian provinces? 
	2014-01-30, pubsCanadaProvinceCountValue = 9
*/
SELECT COUNT(DISTINCT country_id) AS pubsCanadaProvinceCountValue FROM publications 
WHERE (
	(pub_id IN (SELECT DISTINCT pub_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND 
	(country_id LIKE '__c')
);

/* NOT in US and not in Canada  
	2014-01-30, pubsOtherCountryCountValue = 159
*/
SELECT COUNT(DISTINCT country_id) AS pubsOtherCountryCountValue FROM publications 
WHERE (
	(pub_id IN (SELECT DISTINCT pub_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND 
	(
		(country_id NOT LIKE '__u') /* not in US */
		AND 
		(country_id NOT LIKE '__c') /* not in Canada */
	)
); 

