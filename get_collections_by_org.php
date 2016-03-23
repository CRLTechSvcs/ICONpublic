<?php

	$collection_info = array();
	$org_collections_array = array();
	include ("config.php");

  $org_id = $_REQUEST['org_id'];
  //echo "org_id: " . $org_id . "<br/>";

  /*

    2015-10-14 AJE
    based on get_publications_by_org.php
*/


// Sort the multidimensional array: solution from nick ([AT]) nickyost ([DOT]) com in the PHP manual
function custom_sort($a,$b) { // Define the custom sort function
     return $a['collection_title_one']>$b['collection_title_one'];
}


  // 1) get all the collection_ids
	$org_collection_id_SQL = 'SELECT collection_id FROM collections WHERE org_id = "' . $org_id . '"';
  //echo '<br/>org_collection_id_SQL = ' . $org_collection_id_SQL;

	$org_collection_id_result = @mysqli_query($conn, $org_collection_id_SQL) or die( mysqli_error($conn) );
	$org_collections_count = mysqli_num_rows($org_collection_id_result);
	if (!$org_collection_id_result) {
		echo mysql_error();
	} else {
	  //echo '<br/>there were ' . $org_collections_count . ' results';
		while($collection_id_row = mysqli_fetch_array($org_collection_id_result, MYSQL_ASSOC)) {

        // 2015-10-15 brief experiment, adding pub_collections table ; use that in get_publications_by_collection instead
      $this_collection_SQL = 'SELECT C.*, G.org_name, F.format_name, Y.country_name ';
      //$this_collection_SQL .= 'X.pub_coll_note ';
      $this_collection_SQL .= 'FROM collections C ';
      $this_collection_SQL .= 'JOIN organizations G ON G.org_id = C.org_id ';
      $this_collection_SQL .= 'JOIN formats F ON F.format_id = C.format_id ';
      $this_collection_SQL .= 'JOIN countries Y ON Y.country_id = C.country_id_subject ';
      //$this_collection_SQL .= 'JOIN pub_collections X ON X.collection_id = C.collection_id ';
      $this_collection_SQL .= 'WHERE C.collection_id = "' . $collection_id_row['collection_id'] . '"';
      //echo '<br/>this_collection_SQL = ' . $this_collection_SQL . '<br/><br/>';

      $this_collection_result = @mysqli_query($conn, $this_collection_SQL) or die( mysqli_error($conn) );

		  while($row = mysqli_fetch_array($this_collection_result, MYSQL_ASSOC)) {

        $org_name                   = $row['org_name'];
  			$collection_id              = $row['collection_id'];
  			$collection_title_one       = $row['collection_title_one'];
  			$collection_title_two       = $row['collection_title_two'];
        $collection_format          = $row['format_name'];
        $collection_country         = $row['country_name'];
        $collection_home_uri        = $row['collection_home_uri'];
        $collection_CRLprofile_uri  = $row['collection_CRLprofile_uri'];
        $collection_update_date     = $row['collection_update_date'];
        $collection_note            = $row['collection_note'];
          //if($row['pub_coll_note']) { $collection_note .= ' ; ' . $row['pub_coll_note']; }

  			$collection_info = array(
  			  'collection_org_id' => $org_id,
  			  'collection_org_name' => $org_name,
  			  'collection_id' => $collection_id,
  			  'collection_title_one' => $collection_title_one,
  			  'collection_title_two' => $collection_title_two,
  			  'collection_format' => $collection_format,
  			  'collection_country' => $collection_country,
  			  'collection_home_uri' => $collection_home_uri,
  			  'collection_CRLprofile_uri' => $collection_CRLprofile_uri,
  			  'collection_update_date' => $collection_update_date,
  			  'collection_note' => $collection_note
  			);

        array_push($org_collections_array, $collection_info);
      }//end while: each pub
    } // end while collection_id_row

    usort($org_collections_array, "custom_sort"); // call custom sort function

		$encoded = json_encode($org_collections_array);
		die($encoded);

  }// end else: there were results
	mysqli_close($conn);
?>