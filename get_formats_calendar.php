<?php
	$formatInfo = array();
	$formatArray = array();
	include ("config.php");

  /*
    2015-01-28 CFJ
    Populate a JSON object with formats table data
  */

	$formatQuery = "SELECT format_id, format_name, format_note FROM formats";

	$queryResult = @mysqli_query($conn, $formatQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$formatInfo = array(
			  'format_id' => $row['format_id'],
			  'format_name' => $row['format_name'],
			  'format_note' => $row['format_note']
			);
			array_push($formatArray, $formatInfo);
		}//end while
		$encoded = json_encode($formatArray);
		die($encoded);
	}
	mysqli_close($conn);
?>