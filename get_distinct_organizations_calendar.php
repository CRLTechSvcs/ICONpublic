<?php
	$organizationInfo = array();
	$organizationArray = array();
	$pub_id = $_REQUEST['selectedPubId'];
	include ("config.php");

  /*
    2015-01-28 CFJ
    Populate a JSON object with organizations table data for organizations that hold this pub_id

  $organizationQuery = "SELECT org_id, org_name FROM organizations";
	$organizationQuery  = "SELECT DISTINCT o.org_id, o.org_name FROM issues i ";
	$organizationQuery .= "JOIN organizations o ON i.org_id = o.org_id ";
	$organizationQuery .= "WHERE pub_id = '" . $pub_id . "' ";
	$organizationQuery .= "AND i.issue_date <> '0000-00-00' "; // AJE 2016-05-11 zerodate_issues moved to new table
	$organizationQuery .= "ORDER BY org_name";
  */
  // 2015-02-03 AJE: new query to avoid hitting issues table
	$organizationQuery  = "SELECT DISTINCT A2.org_id, o.org_name ";
	$organizationQuery .= "FROM A2issues_per_organization A2 ";
	$organizationQuery .= "JOIN organizations o ON A2.org_id = o.org_id ";
	$organizationQuery .= "WHERE A2.pub_id = '" . $pub_id . "' ";
	$organizationQuery .= "ORDER BY org_name";


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

			array_map("utf8_encode", $organizationInfo);  // new 2015-02-03
			array_push($organizationArray, $organizationInfo);

		}//end while
		$encoded = json_encode($organizationArray);
		die($encoded);
	}
	mysqli_close($conn);
?>