<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$selectedYear = $_REQUEST['selectedYear'];
	$selectedMonth = $_REQUEST['selectedMonth'] + 1;
	$selectedDay = $_REQUEST['selectedDay'];
	$pub_id = urldecode($_REQUEST['selectedPubId']);
	$issues = array();
	include ("config.php");
	$select = 'SELECT * FROM issues_test WHERE year(pub_date) = "' . $selectedYear . 
			  '" AND month(pub_date) = "' . $selectedMonth . 
			  '" AND day(pub_date) = "' . $selectedDay . 
			  '" AND pub_id = "' . $selectedPubId . '"';
	$queryResult = @mysql_query($select);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysql_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempIssueId = $row['issue_id'];
			$tempPubId = $row['pub_id'];
			$tempPubDate = $row['pub_date'];
			$tempRepositoryId = $row['repository_id'];
			$tempPhysCondition = $row['phys_condition'];
			$tempFormat = $row['format'];
			$tempNotes = $row['notes'];
			$issueInfoArray = array("issueId" => $tempIssueId,
							"pubId" => $tempPubId,
							"pubDate" => $tempPubDate,
							"repositoryId" => $tempRepositoryId,
							"physCondition" => $tempPhysCondition,
							"format" => $tempFormat,
							"notes" => $tempNotes);
			array_push($issues, $issueInfoArray);
		}
	}	
	$json = array("issues" => $issues);
	$encoded = json_encode($json);
	die($encoded);
	mysql_close($conn);
?>