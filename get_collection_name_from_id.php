<?php

  /*
    2015-10-14 AJE
    new helper file for, at least, display_publications_by_collection.php
  */

	$pub_info = array();
	$collection_names_array = array();
	include ("config.php");

  $collection_id = $_REQUEST['collection_id'];

  // 0) get the collection_name
  $collection_name_SQL = 'SELECT collection_title_one, collection_title_two FROM collections ';
  $collection_name_SQL .= 'WHERE collection_id = ' . $collection_id . '';
	$collections_name_result = @mysqli_query($conn, $collection_name_SQL) or die( mysqli_error($conn) );
	if (!$collections_name_result) {
		echo mysql_error();
		$collection_name = "";
	} else {
	  while($collection_name_row = mysqli_fetch_array($collections_name_result, MYSQL_ASSOC)) {


    $collection_title_one = $collection_name_row['collection_title_one'];
    $collection_title_two = $collection_name_row['collection_title_two'];

		$pub_info = array(
		  'collection_id' => $collection_id,
		  'collection_title_one' => $collection_title_one,
		  'collection_title_two' => $collection_title_two
		);
        array_push($collection_names_array, $pub_info);
    }//end while: each collection

		$encoded = json_encode($collection_names_array);
		die($encoded);

  }// end else: there were results
	mysqli_close($conn);
?>