<?php
/*
  This script by Constance Jurczyk, ca. 2012
    - gets information about the formats that one publication has issues for in ICON database.

  AJE 2013-11-11
    - revised to also retrieve the number of issues in each format for that one publication
    - CJ's original JSON structure was like:
      {"formatList":["Microfilm","Microopaque","Original","Paper"]}

    - now new setup:
      - orgInfo is the data for any single format
      - orgsArray is the final product, array of the individual reposInfo pieces, converted to JSON and returned
*/

	$selectedPubId = $_REQUEST['selectedPubId'];
	$orgInfo = array();
	$orgsArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");

/*
  //original version
	$reposQuery = 'SELECT DISTINCT r.repos_name, i.issue_date FROM issues i ';
	$reposQuery .= 'JOIN repositories r USING (repos_id) WHERE pub_id = "' . $selectedPubId . '" ';
	$reposQuery .= 'AND i.issue_date <> "0000-00-00" ORDER BY repos_name, issue_date';


  // alternate syntax that takes the same amount of time: 0.125 sec and returns same data set
  $reposQuery = 'SELECT DISTINCT r.repos_id, r.repos_name, i.issue_date FROM issues i, repositories r ';
	$reposQuery .= 'WHERE pub_id = "' . $selectedPubId . '" ';
	$reposQuery .= 'AND i.issue_date <> "0000-00-00" ORDER BY repos_name, issue_date';

  // AJE 2014-09-19 : going to use organizations table from now on; save original code
$reposQuery = 'SELECT DISTINCT r.repos_id, r.repos_name, i.issue_date FROM issues i ';
$reposQuery .= 'JOIN repositories r USING (repos_id) WHERE pub_id = "' . $selectedPubId . '" ';
  $reposQuery .= 'AND i.repos_id = r.repos_id ';
$reposQuery .= 'AND i.issue_date <> "0000-00-00" ORDER BY repos_name, issue_date';
*/

$orgsQuery = 'SELECT DISTINCT o.org_id, o.org_name, i.issue_date ';
$orgsQuery .= 'FROM issues i JOIN organizations o ON i.repos_id = o.org_id ';
$orgsQuery .= 'WHERE pub_id = "' . $selectedPubId . '" ';
$orgsQuery .= 'AND i.issue_date <> "0000-00-00" ORDER BY org_name, issue_date';

//$junkTicker = 0;

	$orgsResult = @mysqli_query($conn, $orgsQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($orgsResult);
	if (!$orgsResult) {
		echo mysql_error();
	} else {
		while($orgRow = mysqli_fetch_array($orgsResult, MYSQL_ASSOC)) {
			$org_id = $orgRow['org_id'];
			$org_name = $orgRow['org_name'];
			$issue_date = $orgRow['issue_date'];

      /*
        AJE 2013-11-13
        this is where one could put the code to check each repository and get the number of issues held;
          but even though it takes lees than a second for each pass through,
          it adds up and makes the page unacceptably slow.
      */

			$orgInfo = array(
			  'org_id' => $org_id,          // for AJE Google Chart API script
			  'repositoryName' => $org_name,   // version for CJ's function displayFormatList in calendar_selection_functions.js
			  'repository_name' => $org_name,  // for AJE Google Chart API script
			  'org_name' => $org_name,  // AJE 2014-09-23 real version for future, coexisting here so as not to break things
			  'pubDate' => $issue_date
      );
			array_push($orgsArray, $orgInfo);

		}
		$json = array("repositories" => $orgsArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>