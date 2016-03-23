<?php
	$archiveStatusInfo = array();
	$archiveStatusArray = array();
	include ("config.php");

  /*
    2015-01-28 CFJ
    Populate a JSON object with archive_status table data
  */

	$archiveStatusQuery = "SELECT archive_status_id, archive_status_name, archive_status_note FROM archive_status";

	$queryResult = @mysqli_query($conn, $archiveStatusQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$archiveStatusInfo = array(
			  'archive_status_id' => $row['archive_status_id'],
			  'archive_status_name' => $row['archive_status_name'],
			  'archive_status_note' =>  $row['archive_status_note']
			);

			array_map("utf8_encode", $archiveStatusInfo);  // new 2015-02-03
			array_push($archiveStatusArray, $archiveStatusInfo);

		}//end while
		$encoded = json_encode($archiveStatusArray);
		die($encoded);
	}
	mysqli_close($conn);
?>