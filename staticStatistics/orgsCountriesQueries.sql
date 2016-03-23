/*
	- 2013-09-26
	- determining number of COUNTRIES where ICON has CONTRIBUTING ORGANIZATIONS for some valid issues
	- using in ICON/javascripts/statistics_countries.js
*/


/*
how many US states?
	2014-01-30, orgsUSstateCountValue = 51
*/
SELECT COUNT(DISTINCT country_id) AS orgsUSstateCountValue FROM organizations
WHERE (
	(org_id IN (SELECT DISTINCT repos_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND
	(country_id LIKE '__u')
);


/*
how many Canadian provinces?
	2014-01-30, orgsUSstateCountValue = 0 [no Canadian libraries contributing]
*/
SELECT COUNT(DISTINCT country_id) AS orgsCanadaProvinceCountValue FROM organizations
WHERE (
	(org_id IN (SELECT DISTINCT repos_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND
	(country_id LIKE '__c')
);


/* NOT in US or Canada
	2014-01-30, orgsOtherCountryCountValue = 1 [pr, technically not US so ok]

*/
SELECT COUNT(DISTINCT country_id) AS orgsOtherCountryCountValue FROM organizations
WHERE (
	(org_id IN (SELECT DISTINCT repos_id FROM issues WHERE issue_date <> '0000-00-00'))
	AND
	(
		(country_id NOT LIKE '__u') /* not in US */
		AND
		(country_id NOT LIKE '__c') /* not in Canada */
	)
);



