<?php

/*
	2015-01-26
	testing where the JSON fails
*/

	$selectedPubId = 'sn84031492';
	$innerArray = array();
	$issueArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");

    // AJE 2014-09-30 using organizations instead of repositories
	$select  = 'SELECT i.*, c.condition_name, f.format_name, a.archive_status_name, o.org_id, o.org_name ';
	$select .= 'FROM issues i, conditions c, formats f, archive_status a, organizations o ';
	$select .= 'WHERE i.condition_id = c.condition_id ';
	$select .= 'AND i.format_id = f.format_id ';
	$select .= 'AND i.archive_status_id = a.archive_status_id ';
	$select .= 'AND i.repos_id = o.org_id ';
	// $select .= 'AND issue_date <> "0000-00-00"'; // AJE 2016-05-11 zerodate_issues moved to new table
	$select .= 'AND pub_id = "' . $selectedPubId . '" ORDER BY issue_date';

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$issue_id = $row['issue_id'];
			$issue_date = $row['issue_date'];
			/*
			$org_id = $row['repos_id'];
			$org_name = $row['repos_name'];
			*/
      $org_id = $row['org_id'];
			$org_name = $row['org_name'];


			$condition_name = $row['condition_name'];
			$format_name = $row['format_name'];
			if ($format_name == 'Digital (pdf)') $format_name = 'Digital pdf';
			if ($format_name == 'Digital (tiff)') $format_name = 'Digital tiff';
			if ($format_name == 'Digital (Direct electronic)') $format_name = 'Digital direct electronic';
			if ($format_name == 'Digital (unspecified)') $format_name = 'Digital unspecified';
			$archive_status_name = $row['archive_status_name'];
			/* $tempProvenance = $row['provenance']; */
			$tempProvenance = $row['provenance_id'];
			$tempUpdateDate = $row['update_date'];
			$tempNotes = $row['issue_note'];
			$tempRawIssueData = $row['rawIssueData'];

			$innerArray = array(
			  "issueId" => $issue_id,
			  "pubDate" => $issue_date,
			  "repositoryId" => $org_id,
			  "repositoryName" => $org_name,
			  "physCondition" => $condition_name,
			  "format" => $format_name,
			  "archiveStatus" => $archive_status_name,
			  "provenance" => $tempProvenance,
			  "updateDate" => $tempUpdateDate,
			  "notes" => $tempNotes,
			  "rawIssueData" => $tempRawIssueData
			);
			array_push($issueArray, $innerArray);
		}
		$json = array("allIssues" => $issueArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>
