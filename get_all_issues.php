<?php
	$pub_id = $_REQUEST['selectedPubId'];
	$innerArray = array();
	$issueArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");


  /*********************************************************************
    // AJE 2015-01-28 ORIGINAL SQL BLOCK preserved: get_all_issues.php.before2015
  **********************************************************************/
	$select  = 'SELECT * FROM issues ';
	$select .= 'WHERE pub_id = "' . $pub_id . '" ';
  $select .= 'AND issue_date <> "0000-00-00"  ORDER BY issue_date';

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
      //2015-01-28 major revision
			$innerArray = array(
			  "issue_id" => $row['issue_id'],
			  "issue_date" => $row['issue_date'],
			  "org_id" => $row['org_id'],
			  "org_name" => 'tba', // to be filled in javascript
			  "condition_id" => $row['condition_id'],
			  "condition_name" => 'tba',
			  "format_id" => $row['format_id'],
			  "format_name" => 'tba',
			  "archive_status_id" => $row['archive_status_id'],
			  "archive_status_name" => 'tba',
			  "provenance_id" => $row['provenance_id'],
			  "update_date" => $row['update_date'],
			  "issue_note" => $row['issue_note'],
			  "rawIssueData" => $row['rawIssueData']
			);
			array_map("utf8_encode", $innerArray);  // new 2015-02-03
			array_push($issueArray, $innerArray);
		}
		$json = array("allIssues" => $issueArray);
		$encoded = json_encode($json);

    // AJE 2015-02-03 trying to resolve parse.JSON error when it gets to Javascript
    //      hide this section to get it to appear in browser for debuging
		$Content_Length = mb_strlen(serialize($encoded), '8bit');
		$Content_Length = $Content_Length + 1;
    //echo 'presumed Content_Length = ' . $Content_Length . '.';
		//header('Content-Length: ' . $Content_Length . '; Content-Type: application/json; charset=utf-8');
    // resume original


		die($encoded);
	}
	mysqli_close($conn);
?>