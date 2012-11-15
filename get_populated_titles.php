<?php
	include ("config.php");
	$tempArray = array();
	$outerArray = array();
	//$select  = 'SELECT p.pub_id FROM issues_test it, publications p WHERE it.pub_id = p.pub_id';	
	//$select  = 'SELECT p.pub_id, count(issue_id) FROM issues_test it, publications p WHERE p.pub_id = it.pub_id AND p.pub_id LIKE "sn8504%"';	
	$select  = 'SELECT p.pub_id, count(issue_id) FROM issues_test it, publications p WHERE p.pub_id = it.pub_id AND p.pub_id LIKE "sn8%" AND formerFrequency321 <> "" GROUP by pub_id';	
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempPubId = $row['pub_id'];
			$tempCount = $row['count(issue_id)'];
			echo $tempPubId . " " . $tempCount . "<br />";
			//$tempArray = array( "pubId" => $tempPubId, "issueCount" => $tempCount);
			//array_push($outerArray, $tempArray);
		}
		//$encoded = json_encode($outerArray);
		//die($encoded);
	}
	mysqli_close($conn);
?>