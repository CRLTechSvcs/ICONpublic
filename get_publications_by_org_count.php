<?php

	$pub_info = array();
	$org_pubs_array = array();
	include ("config.php");

  $org_id = $_REQUEST['org_id'];
  //echo "org_id: " . $org_id . "<br/>";

  /*
    how many publications does org_id have issues for?
  */

  // AJE 2016-04-28 reverted to issues table : too much trouble keeping C3publications_per_org up to date
	//$org_pub_count_SQL = 'SELECT COUNT(DISTINCT pub_id) AS org_pub_count FROM C3publications_per_org WHERE org_id = "' . $org_id . '"';
	$org_pub_count_SQL = 'SELECT COUNT(DISTINCT pub_id) AS org_pub_count FROM issues WHERE org_id = "' . $org_id . '"';

  //echo '<br/>org_pub_count_SQL = ' . $org_pub_count_SQL . ';';

	$org_pub_count_result = @mysqli_query($conn, $org_pub_count_SQL) or die( mysqli_error($conn) );
	if (!$org_pub_count_result) {
		echo mysql_error();
	} else {
	  while($row = mysqli_fetch_array($org_pub_count_result, MYSQL_ASSOC)) {
      $org_pub_count_array = array( 'org_pub_count' => $row['org_pub_count'] );
      array_push($org_pubs_array, $org_pub_count_array);

    	$encoded = json_encode($org_pubs_array);
	  	die($encoded);
    }// end while
  }// end else: there were results
	mysqli_close($conn);
?>