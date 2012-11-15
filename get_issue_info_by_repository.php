<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$selectedRepositoryId = $_REQUEST['selectedRepositoryId'];
	$selectedYear = $_REQUEST['selectedYear'];
	$selectedMonth = $_REQUEST['selectedMonth'] + 1;
	$selectedDay = $_REQUEST['selectedDay'];
	$pub_id = urldecode($_REQUEST['selectedPubId']);
	$issues = array();
	include ("config.php");
	$select = 'SELECT * FROM issues_test WHERE year(pub_date) = "' . $selectedYear . 
			  '" AND month(pub_date) = "' . $selectedMonth . 
			  '" AND day(pub_date) = "' . $selectedDay . 
			  '" AND pub_id = "' . $selectedPubId . 
			  '" AND repository_id = "' . $selectedRepositoryId . '"';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysqli_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempIssueId = $row['issue_id'];
			$tempPubId = $row['pub_id'];
			$tempPubDate = $row['pub_date'];
			$tempRepositoryId = $row['repository_id'];
			$tempProvenance = $row['provenance'];
			$tempPhysCondition = $row['phys_condition'];
			$tempFormat = $row['format'];
			$tempNotes = $row['notes'];
			$issueInfoArray = array("issueId" => $tempIssueId,
							"pubId" => $tempPubId,
							"pubDate" => $tempPubDate,
							"repositoryId" => $tempRepositoryId,
							"provenance" => $tempProvenance,
							"physCondition" => $tempPhysCondition,
							"format" => $tempFormat,
							"notes" => $tempNotes);
			array_push($issues, $issueInfoArray);
		}
	}	
	$json = array("issues" => $issues);
	$encoded = json_encode($json);
	die($encoded);
	mysqli_close($conn);
?>