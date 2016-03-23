<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$selectedYear = $_REQUEST['selectedYear'];
	$selectedMonth = $_REQUEST['selectedMonth'] + 1;
	$selectedDay = $_REQUEST['selectedDay'];
	$pub_id = urldecode($_REQUEST['selectedPubId']);
	$formats = array();
	include ("config.php");
	$select = 'SELECT DISTINCT format FROM issues_test WHERE year(pub_date) = "' . $selectedYear . 
			  '" AND month(pub_date) = "' . $selectedMonth . 
			  '" AND day(pub_date) = "' . $selectedDay . 
			  '" AND pub_id = "' . $selectedPubId . 
			  '" ORDER BY format';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysqli_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempFormat = $row['format'];
			array_push($formats, $tempFormat);
		}
	}	
	$json = array("formats" => $formats);
	$encoded = json_encode($json);
	die($encoded);
	mysqli_close($conn);
?>