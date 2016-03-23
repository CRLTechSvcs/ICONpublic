<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$innerArray = array();
	$issueArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");

  $sqlZeroDateIssues  = 'SELECT i.*, c.condition_name, f.format_name, a.archive_status_name, o.org_id, o.org_name ';
	$sqlZeroDateIssues .= 'FROM issues i, conditions c, formats f, archive_status a, organizations o ';
	$sqlZeroDateIssues .= 'WHERE i.condition_id = c.condition_id AND i.format_id = f.format_id AND i.archive_status_id = a.archive_status_id ';
	$sqlZeroDateIssues .= 'AND i.org_id = o.org_id AND issue_date = "0000-00-00" ';
	$sqlZeroDateIssues .= 'AND i.specificIssuesCreated = "0" ';
	$sqlZeroDateIssues .= 'AND pub_id = "' . $selectedPubId . '" ORDER BY org_name';

	$queryResult = @mysqli_query($conn, $sqlZeroDateIssues) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$issue_id = $row['issue_id'];
			$issue_date = $row['issue_date'];
			$rawIssueData = $row['rawIssueData'];
			$org_id = $row['org_id'];
			$org_name = $row['org_name'];
			$condition_name = $row['condition_name'];
			$format_name = $row['format_name'];
			if ($format_name == 'Digital (pdf)') $format_name = 'Digital pdf';
			if ($format_name == 'Digital (tiff)') $format_name = 'Digital tiff';
			if ($format_name == 'Digital (Direct electronic)') $format_name = 'Digital direct electronic';
			if ($format_name == 'Digital (unspecified)') $format_name = 'Digital unspecified';
			$archive_status_name = $row['archive_status_name'];
			$update_date = $row['update_date'];
			$issue_note = $row['issue_note'];


			$innerArray = array("issueId" => $issue_id, "issue_date" => $issue_date, "org_id" => $org_id, "org_name" => $org_name,
			                    "condition_name" => $condition_name, "format_name" => $format_name, "archive_status_name" => $archive_status_name, "update_date" => $update_date, "issue_note" => $issue_note, "rawIssueData" => $rawIssueData);
			array_push($issueArray, $innerArray);
		}
		$json = array("zeroDateIssues" => $issueArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>