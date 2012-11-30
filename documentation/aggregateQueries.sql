
SELECT pub_id, COUNT(*) AS issuesForPublication 
	FROM issues 
	GROUP BY pub_id 
	ORDER BY issuesForPublication DESC;

/* use next to verify logic of above query, should return same result */
SELECT COUNT(*) FROM issues WHERE pub_id = '00062183';


/*********************************************
	2012-11-27
	- issues by specific repository: Amy wants 'AAS, LC, WNA, others'
*/
SELECT COUNT(*) FROM issues;
SELECT issue_id, pub_id, issue_date, repos_id, format_id 
FROM issues 
/* WHERE repos_id = 'DLC'; 832194 */
/* WHERE repos_id = 'AQM'; 1664910 */
/* WHERE repos_id = 'FLNEW'; 238352   FLNEW = WNA */
WHERE repos_id NOT IN ('DLC', 'AQM', 'FLNEW'); /* 4878855 */
/* 
	these #s only come to 6543765 out of 7614311; deficit 1070546
*/

SELECT repos_id, COUNT(*) AS issuesForRepos, COUNT(format_id) AS inFormats
	FROM issues 
	GROUP BY repos_id 
	ORDER BY issuesForRepos DESC; /* 3039 repositories */

/*********************************************/




