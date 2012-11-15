<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$formatArray = array();
	include ("config.php");
	
	$select  = 'SELECT DISTINCT f.format_name FROM formats f, issues i WHERE i.format_id = f.format_id AND ';
	$select .= 'i.pub_id = "' . $selectedPubId . '"';
	
	
	$select  = 'SELECT formats.format_name FROM formats WHERE formats.format_id IN ';
	$select .= '(SELECT DISTINCT(issues.format_id) FROM issues WHERE issues.pub_id = "'. $selectedPubId . '") ';
  $select .= 'ORDER BY formats.format_name';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempFormat = $row['format_name'];
			if ($tempFormat == 'Digital (pdf)') {
				$tempFormat = 'Digital pdf';
			} else if ($tempFormat == 'format unspecified/unknown') {
				$tempFormat = 'Unspecified or unknown';
			}
			array_push($formatArray, $tempFormat);
			sort($formatArray);
		}
		$json = array("formatList" => $formatArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>