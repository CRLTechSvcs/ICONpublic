<?php

  /*
    2015-10-14 AJE
    new helper file for, at least, display_publications_by_collection.php
  */

	$collection_info = array();
	$collection_orgs_array = array();
	include ("config.php");

  $collection_id = $_REQUEST['collection_id'];

  // 0) get the collection_org
  $collection_org_SQL = 'SELECT C.org_id, G.org_name ';
  $collection_org_SQL .= 'FROM collections C ';
  $collection_org_SQL .= 'JOIN organizations G ON G.org_id = C.org_id ';
  $collection_org_SQL .= 'WHERE collection_id = ' . $collection_id . '';
	$collections_name_result = @mysqli_query($conn, $collection_org_SQL) or die( mysqli_error($conn) );
	if (!$collections_name_result) {
		echo mysql_error();
		$collection_org_id    = "";
		$collection_org_name  = "";
	} else {
	  while($collection_org_row = mysqli_fetch_array($collections_name_result, MYSQL_ASSOC)) {


    $collection_org_id = $collection_org_row['org_id'];
    $collection_org_name = $collection_org_row['org_name'];

		$collection_info = array(
		  'collection_id' => $collection_id,
		  'collection_org_id' => $collection_org_id,
		  'collection_org_name' => $collection_org_name
		);
        array_push($collection_orgs_array, $collection_info);
    }//end while: each collection

		$encoded = json_encode($collection_orgs_array);
		die($encoded);

  }// end else: there were results
	mysqli_close($conn);
?>