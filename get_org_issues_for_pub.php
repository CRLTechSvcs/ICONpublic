<?php
/*
  AJE 2013-11-12
  - this script is called from function display_orgs_list in calendar_selection_functions.js
  - gets the number of issues for a publication at a given repository
  - needs to get the pub_id and org_id as input
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
	$org_name       = $_REQUEST['org_name'];
	$reposInfo = array();
	$reposArray = array();
	include ("config.php");


  /***********************************************************
    // AJE 2015-01-27 original SQL
  $this_sql = 'SELECT COUNT(*) FROM issues ';
  $this_sql .= 'WHERE pub_id = "' . $selectedPubId . '" AND org_id = "' . $org_id . '" ';
  $this_sql .= 'AND issue_date <> "0000-00-00"';  // AJE 2016-05-11 zerodate_issues moved to new table
  ***********************************************************/

    // AJE 2015-01-27 NEW CRAZY VERSION with prefilled table
  /* NO IFs ABOUT IT: THIS IS TESTING FOR ALL PUBS
  if (
      ($selectedPubId == 'sn84023370') || // New-Hampshire Mercury ...
      // rest of these pub_ids have > 100,000 issues, in order,
      ($selectedPubId == 'sn83045536') || ($selectedPubId == 'sn86081122') || ($selectedPubId == 'sn82015487') ||
      ($selectedPubId == 'sn94080799') || ($selectedPubId == 'sn84031523') || ($selectedPubId == 'sn83030385') ||
      ($selectedPubId == 'sn84026936') || ($selectedPubId == 'sn84031492')
     )
  {
    $this_sql = 'SELECT num_issues FROM A2issues_per_organization ';
    $this_sql .= 'WHERE pub_id = "' . $selectedPubId . '" AND org_id = "' . $org_id . '" ';
  }
  */

  $this_sql = 'SELECT num_issues FROM A2issues_per_organization ';
  $this_sql .= 'WHERE pub_id = "' . $selectedPubId . '" AND org_id = "' . $org_id . '" ';

  //echo $this_sql;
  $repos_issues_statement = $conn->prepare($this_sql);
  $repos_issues_statement->execute();
  $repos_issues_statement->store_result();
  if ($repos_issues_statement->num_rows > 0){ //got count of pubs for this org_id
    $repos_issues_statement->bind_result($num_issues);
    while($repos_issues_statement->fetch()) { $num_issues = $num_issues; } // end while
    $reposInfo = array(
      'org_id' => $org_id,
      'org_name' => $org_name,
      'pub_id' => $selectedPubId,
      'issues' => $num_issues
      //'issues' => '"' . $num_issues . '"'
    );

    array_map("utf8_encode", $reposInfo);  // new 2015-02-03
		array_push($reposArray, $reposInfo);
		$encoded = json_encode($reposArray);

		die($encoded);
	}
	mysqli_close($conn);
?>