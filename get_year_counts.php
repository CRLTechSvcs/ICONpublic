<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	
	if (isset($_REQUEST["selectedPubId"])) 	{
		$pub_id = urldecode($_REQUEST["selectedPubId"]);
	} else {
		die("No pub_id parameter was supplied");
		exit;
	}
	
	$yearArray = array();
	$tempArray = array();
	$issueCountArray = array();
	$yr = "";
	$tableChoice = "issues_test";
	include ("config.php");

	//Select years with issues for this title
	$strSQLgetYears = "SELECT DISTINCT LEFT(" . $tableChoice . ".pub_date, 4) AS temp_year FROM " . $tableChoice . " ";
	$strSQLgetYears .= " WHERE " . $tableChoice . ".pub_id = '" . $pub_id ."'";
	$strSQLgetYears .= " ORDER BY " . $tableChoice . ".pub_date";
	$result = mysqli_query($conn, $strSQLgetYears) or die( mysqli_error($conn) );
	if ($result) {
		while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
			$tempYear = $row["temp_year"];
			array_push($yearArray, $tempYear);
		}
	}
	
	//Count issues by year
	$strSQLgetCounts = "SELECT COUNT(DISTINCT " . $tableChoice . ".pub_date) AS count FROM " . $tableChoice . " ";
	$strSQLgetCounts .= " WHERE " . $tableChoice . ".pub_id = '" . $pub_id ."'";
	$strSQLgetCounts .= " AND LEFT(" . $tableChoice . ".pub_date,4) = '";
	foreach ($yearArray as $yr) {
		$strSQLfinal = $strSQLgetCounts . $yr . "'";
		$result = mysqli_query($conn, $strSQLfinal) or die( mysqli_error($conn) );
		if (! $result ) echo "Query problem";
		if ($result) { 
			// Query ran OK, so display the records
			if(mysqli_num_rows($result) == 0) {
				// If no records were retrieved, return that message
				echo "No records were retrieved for this pub_id";
			} else {
				// Otherwise, return all records
				while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
					$tempArray['year'] = $yr;
					$tempArray['count'] = $row['count'];
					array_push($issueCountArray, $tempArray);
				}
			}
		}
	}
	$json = array("issueCountArray" => $issueCountArray);
	$encoded = json_encode($json);
	die($encoded);
	mysql_close($conn);
?>