<?php

	$pub_info = array();
	$collection_pubs_array = array();
	include ("config.php");

  $collection_id = $_REQUEST['collection_id'];
  //echo "collection_id: " . $collection_id . "<br/>";

  /*
    2015-10-14
    companion file for display_publications_by_collection.php
  */


// Sort the multidimensional array: solution from nick ([AT]) nickyost ([DOT]) com in the PHP manual
function custom_sort($a,$b) { // Define the custom sort function
     return $a['pub_title']>$b['pub_title'];
}

  // 1) get all the pub_ids
	$collections_pub_id_SQL = 'SELECT DISTINCT pub_id FROM pub_collections WHERE collection_id = "' . $collection_id . '"';
  //echo '<br/>collections_pub_id_SQL = ' . $collections_pub_id_SQL;

	$collections_pub_id_result = @mysqli_query($conn, $collections_pub_id_SQL) or die( mysqli_error($conn) );
	$collection_pubs_count = mysqli_num_rows($collections_pub_id_result);
	if (!$collections_pub_id_result) {
		echo mysql_error();
	} else {
	  //echo '<br/>there were ' . $collection_pubs_count . ' results';
		while($pub_id_row = mysqli_fetch_array($collections_pub_id_result, MYSQL_ASSOC)) { // for every title in that collection...
      $this_pub_SQL = 'SELECT DISTINCT p.pub_id, p.pub_title, p.pub_city, p.country_id, p.pub_bgnDate, p.pub_endDate, ';
      $this_pub_SQL .= 'Y.country_name ';
      $this_pub_SQL .= 'FROM publications p ';
      $this_pub_SQL .= 'JOIN countries Y ON Y.country_id = p.country_id ';
      $this_pub_SQL .= 'WHERE p.pub_id = "' . $pub_id_row['pub_id'] . '" ';
      $this_pub_SQL .= 'ORDER BY pub_title, pub_city, pub_bgnDate, pub_endDate ';
      //$this_pub_SQL .= 'ORDER BY pub_title, pub_city, country_name, pub_bgnDate, pub_endDate ';
      //echo '<br/>this_pub_SQL = ' . $this_pub_SQL . '<br/><br/>';

      $this_pub_result = @mysqli_query($conn, $this_pub_SQL) or die( mysqli_error($conn) );

		  while($row = mysqli_fetch_array($this_pub_result, MYSQL_ASSOC)) {

  			$pub_id = $row['pub_id'];
  			$pub_title = $row['pub_title'];
  			$pub_city = $row['pub_city'];
  			$pub_bgnDate = $row['pub_bgnDate'];
  			$pub_endDate = $row['pub_endDate'];
  			$country_id = $row['country_id'];
  			$country_name = $row['country_name'];
  			$pub_coll_note = ''; //filling pub_coll_note below

  			//pub_coll_note makes result set indistinct: multiple occurences of same pub_ids, so separate query
  			$pub_coll_note_SQL = 'SELECT DISTINCT PC.pub_coll_note, CL.collection_update_date ';
  			$pub_coll_note_SQL .= 'FROM pub_collections PC ';
  			$pub_coll_note_SQL .= 'JOIN collections CL ON CL.collection_id = PC.collection_id ';
  			$pub_coll_note_SQL .= 'WHERE PC.pub_id = "' . $pub_id . '" ';
  			$pub_coll_note_SQL .= 'AND PC.collection_id = ' . $collection_id . ' ';
  			//echo '<br/>pub_coll_note_SQL = ' . $pub_coll_note_SQL . '<br/><br/>';
        $PCN_result = @mysqli_query($conn, $pub_coll_note_SQL) or die( mysqli_error($conn) );
        while($PCN_row = mysqli_fetch_array($PCN_result, MYSQL_ASSOC)) {
          if( strlen($pub_coll_note) > 0) { $pub_coll_note .= ' ; '; }// end if
          $pub_coll_note .= $PCN_row['pub_coll_note'];
          $pub_coll_note .= '; collection info updated: ' . $PCN_row['collection_update_date'];
        }//end while pub_coll_notes

  			$pub_info = array(
  			  'collection_id' => $collection_id,
  			  'pub_id' => $pub_id,
  			  'pub_title' => $pub_title,
  			  'pub_city' => $pub_city,
  			  'pub_bgnDate' => $pub_bgnDate,
  			  'pub_endDate' => $pub_endDate,
  			  'country_id' => $country_id,
  			  'country_name' => $country_name,
  			  'pub_coll_note' => $pub_coll_note
  			);

        array_push($collection_pubs_array, $pub_info);
      }//end while: each pub
    } // end while pub_id_row

    usort($collection_pubs_array, "custom_sort"); // call custom sort function

		$encoded = json_encode($collection_pubs_array);
		die($encoded);

  }// end else: there were results
	mysqli_close($conn);
?>