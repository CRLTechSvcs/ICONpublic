<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$selectedYear = $_REQUEST['selectedYear'];
	$monthNameArray = array();
	$monthIndexArray = array();
	include ("config.php");
	
	$select  = 'SELECT monthname(pub_date) AS monthName, month(pub_date)-1 AS monthIndex FROM issues_test ' ;
	$select .= 'WHERE year(pub_date) = "' . $selectedYear . '" AND pub_id = "' . $selectedPubId . '" ';
	$select .= 'GROUP BY monthname( pub_date ) , month( pub_date ) ';
	$select .= 'ORDER BY monthIndex';
	
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempMonthName = $row['monthName'];
			$tempMonthIndex = $row['monthIndex'];
			array_push($monthNameArray, $tempMonthName);
			array_push($monthIndexArray, $tempMonthIndex);
		}
		$json = array("availableMonthNames" => $monthNameArray, "availableMonthIndexes" => $monthIndexArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>