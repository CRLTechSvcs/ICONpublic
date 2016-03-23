<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$selectedYear = $_REQUEST['selectedYear'];
	$selectedMonth = $_REQUEST['selectedMonth'];
	$dayArray = array();
	include ("config.php");
	$select = 'SELECT * FROM issues_test WHERE year(pub_date) = "' . $selectedYear . '" AND month(pub_date) = "' . $selectedMonth . '" AND pub_id = "' . $selectedPubId . '" ORDER BY pub_date';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else if ($numrows > 0) {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempIssueDate = $row['pub_date'];
			array_push($dayArray, $tempIssueDate);
		}
		$json = array("issueDates" => $dayArray);
		$encoded = json_encode($json);
		die($encoded);
	} else {
		echo "No issues published this month";
	}
	mysqli_close($conn);
?>