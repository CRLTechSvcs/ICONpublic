<?php
	$organizationInfo = array();
	$organizationArray = array();
	include ("config.php");

  /*
    2015-01-28 CFJ
    Populate a JSON object with organizations table data

   [was under different name : AJE copied on 2016-05-06 to use for Amy's dropdown list of organizations on search.php]
  */

	$organizationQuery = "SELECT org_id, org_name FROM organizations ORDER BY org_name";

	$queryResult = @mysqli_query($conn, $organizationQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$organizationInfo = array(
			  'org_id' => $row['org_id'],
			  'org_name' => $row['org_name']
			);
			array_push($organizationArray, $organizationInfo);
		}//end while
		$encoded = json_encode($organizationArray);
		die($encoded);
	}
	mysqli_close($conn);
?>