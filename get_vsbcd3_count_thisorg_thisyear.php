<?php

  /* get_vsbcd3_count_thisorg_thisyear.php

    - input: pub_id (see config.php), org_id, Year
    - output: JSON data: how many issues the org_id has for Year
  */

  require_once('config.php');

  if ( isset($_REQUEST['pub_id']) ){
    $pub_id = $_REQUEST['pub_id'];
  } else { // fill default pub_id
    $pub_id = 'sn84023370';
  }

  if ( isset($_REQUEST['org_id']) ){
    $org_id = $_REQUEST['org_id'];
  } else { // fill default org_id
    $org_id = '@@@';
  }

  if ( isset($_REQUEST['Volume']) ){
    $this_issue_date = $_REQUEST['Volume'];
  } else { // fill default year
    $this_issue_date = '1900';
  }

  $output_array = array();

  /*
    how many publications does org_id have issues for in this year?
      - could be more than 1 format per date
  */

	$org_pub_count_SQL = 'SELECT COUNT(DISTINCT issue_date, format_id) as org_pub_count FROM issues ';
	$org_pub_count_SQL .= 'WHERE org_id = "' . $org_id . '" ';
	$org_pub_count_SQL .= 'AND issue_date LIKE "' . $this_issue_date . '%" ';
  //echo '<br/>org_pub_count_SQL = ' . $org_pub_count_SQL . ';';

	$org_pub_count_result = @mysqli_query($conn, $org_pub_count_SQL) or die( mysqli_error($conn) );
	if (!$org_pub_count_result) {
		echo mysql_error();
	} else {
	  while($row = mysqli_fetch_array($org_pub_count_result, MYSQL_ASSOC)) {
      $org_pub_count_array = array( 'org_pub_count' => $row['org_pub_count'] );
      array_push($output_array, $org_pub_count_array);

    	$encoded = json_encode($output_array);
	  	die($encoded);
    }// end while
  }// end else: there were results
	mysqli_close($conn);
?>