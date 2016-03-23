<?php
/*
  AJE 2013-11-12
  - this script is called from function displayOrgsList in calendar_selection_functions.js
  - gets the number of issues for a publication at a given repository
  - needs to get the pub_id and repos_id as input
*/

/*
// not tested: http://www.levihackwith.com/code-snippet-how-to-sort-an-array-of-json-objects-by-property/
function sortByProperty(property) {
  'use strict';
    return function (a, b) {
    var sortStatus = 0;
    if (a[property] < b[property]) {
      sortStatus = -1;
    } else if (a[property] > b[property]) {
      sortStatus = 1;
    }
    return sortStatus;
  };
}

*/


	$selectedPubId  = $_REQUEST['selectedPubId'];
	$org_id         = $_REQUEST['org_id'];
	$reposInfo = array();
	$reposArray = array();
	include ("config.php");


    // AJE 2015-01-27 original SQL
  $issues_query = 'SELECT COUNT(*) FROM issues ';
  $issues_query .= 'WHERE pub_id = "' . $selectedPubId . '" AND repos_id = "' . $org_id . '" ';
  $issues_query .= 'AND issue_date <> "0000-00-00"';

  //echo $issues_query;
  $repos_issues_statement = $conn->prepare($issues_query);
  $repos_issues_statement->execute();
  $repos_issues_statement->store_result();
  if ($repos_issues_statement->num_rows > 0){ //got count of pubs for this org_id
    $repos_issues_statement->bind_result($num_issues);
    while($repos_issues_statement->fetch()) { $num_issues = $num_issues; } // end while
    $reposInfo = array(
      'org_id' => $org_id,
      'org_name' => $_REQUEST['org_name'],
      'pub_id' => $selectedPubId,
      'issues' => $num_issues
      //'issues' => '"' . $num_issues . '"'
    );

		array_push($reposArray, $reposInfo);
		$encoded = json_encode($reposArray);

		die($encoded);
	}
	mysqli_close($conn);
?>