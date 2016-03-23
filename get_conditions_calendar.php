<?php
	$conditionInfo = array();
	$conditionArray = array();
	include ("config.php");

  /*
    2015-01-28 CFJ
    Populate a JSON object with conditions table data
  */

	$conditionQuery = "SELECT condition_id, condition_name, condition_note FROM conditions";

	$queryResult = @mysqli_query($conn, $conditionQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$conditionInfo = array(
			  'condition_id' => $row['condition_id'],
			  'condition_name' => $row['condition_name'],
			  'condition_note' => $row['condition_note']
			);
			array_push($conditionArray, $conditionInfo);
		}//end while
		$encoded = json_encode($conditionArray);
		die($encoded);
	}
	mysqli_close($conn);
?>