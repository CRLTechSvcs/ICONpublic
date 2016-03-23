use icondata;

/*
  2014-08-14
  see original pubsCountriesQueries.sql and get_statistics_countries_static.php
*/

SELECT /* only valid issues */
	CONCAT("All Canada for countryInfo[issue_dates]: ", COUNT(i.issue_id)) AS numIssues,
	MIN(i.issue_date) AS minDate,
	MAX(i.issue_date) maxDate,
	COUNT(DISTINCT p.pub_id) AS numPublicationsWholeCountry,
	COUNT(DISTINCT p.country_id) AS numStateProvinces
FROM issues i
JOIN publications p ON p.pub_id = i.pub_id
WHERE (
	i.issue_date <> '0000-00-00' AND(p.pub_id
		IN (SELECT DISTINCT i.pub_id FROM issues WHERE issue_date <> '0000-00-00')
	)
	AND
	(p.country_id LIKE '__c' AND p.country_id <> 'ncc') /* code 'ncc' is an area */
)

UNION


SELECT /* incl. invalid issues */
	CONCAT("All Canada for countryInfo[country_issues]: ", COUNT(i.issue_id)) AS numIssuesWholeCountry,
	MIN(i.issue_date) AS minDate,
  MAX(i.issue_date) AS maxDate,
  COUNT(DISTINCT p.pub_id) AS numPublicationsWholeCountry,
  COUNT(DISTINCT p.country_id) AS numStateProvinces
FROM issues i
JOIN publications p ON p.pub_id = i.pub_id
WHERE (
  /* NO ISSUE CLAUSE HERE */
	p.country_id LIKE '__c' AND p.country_id <> 'ncc'
)


UNION


SELECT /* ignore issues */
	CONCAT("All Canada for countryInfo[country_pubs]: ", "...") AS numIssuesWholeCountry,
	CONCAT("0000-00-00") AS minDate,
  MAX("0000-00-00") AS maxDate,
  COUNT(DISTINCT p.pub_id) AS numPublicationsWholeCountry,
  COUNT(DISTINCT p.country_id) AS numStateProvinces
FROM publications p
WHERE (
  /* NO ISSUE CLAUSE HERE */
	p.country_id LIKE '__c' AND p.country_id <> 'ncc'
);

