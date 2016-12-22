<?php
/*

  2015-09-24
  AJE: modeled after get_format_list.php:
    get information about collections
    in which any issues of this title are included,
  ...

  2015-10-08
  AJE: new table pub_collections: has pub_id and collection_id ;
    v1 had us looking through issues table for the collection_id
    v2 now, we look up the collection_id from the much smaller pub_collections table


*/

	$this_pub_id = $_REQUEST['pub_id'];

	$collectionInfo = array();
	$collectionArray = array();
	include ("config.php");

	//echo '<br/>hello<br/>';

	$collectionQuery  = 'SELECT c.collection_id, c.collection_title_one, c.collection_title_two, c.collection_note, ';
	$collectionQuery .= 'G.org_id, G.org_name, G.org_city, G.country_id, ';
	$collectionQuery .= 'Y.country_name AS org_country_name ';
	$collectionQuery .= 'FROM collections c ';
	$collectionQuery .= 'JOIN organizations G ON G.org_id = c.org_id ';
	$collectionQuery .= 'JOIN countries Y ON Y.country_id = G.country_id ';
	$collectionQuery .= 'WHERE c.collection_id IN ( ';
	  //$collectionQuery .= 'SELECT DISTINCT(collection_id) FROM issues ';
	  $collectionQuery .= 'SELECT DISTINCT(collection_id) FROM pub_collections ';
	  //$collectionQuery .= 'WHERE pub_id = "'. $this_pub_id . '" AND issue_date != "0000-00-00" '; // AJE 2016-05-11 zerodate_issues moved to new table
	  $collectionQuery .= 'WHERE pub_id = "'. $this_pub_id . '" ';
	  $collectionQuery .= 'AND collection_id <> 59 '; /* AJE 2016-05-10 to accomodate ProQuest not wanting to see their own Black Newspapes collection listed */
  $collectionQuery .= ') ORDER BY c.collection_title_one';
//echo '<hr/>collectionQuery = ' . $collectionQuery . '<hr/>';
	$collectionResult = @mysqli_query($conn, $collectionQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($collectionResult);
	if (!$collectionResult) {
		echo mysql_error();
	} else {
    while($collection_row = mysqli_fetch_array($collectionResult, MYSQL_ASSOC)) {


      /* titles here are still unweildy: pass both titles to javascript and construct a tooltip instead
			if ( $collection_row['collection_title_one'] != $collection_row['collection_title_two']){
			  $collection_title = $collection_row['collection_title_one'] . ' : ' . $collection_title = $collection_row['collection_title_two'];
      } else {
        $collection_title = $collection_row['collection_title_one'];
      }
      */
      $collection_title_one = $collection_row['collection_title_one'];
      $collection_title_two = $collection_row['collection_title_two'];

			$collection_org_title = $collection_row['org_name'] . ' (' . $collection_row['org_city'] . ', ' . $collection_row['org_country_name'] . ')';

			$collectionInfo = array(
			  'collection_id' => $collection_row['collection_id'],
			  'collection_title_one' => $collection_title_one,
			  'collection_title_two' => $collection_title_two,
        'collection_org_id' => $collection_row['org_id'],
        'collection_org_name' => $collection_row['org_name'],
			  'collection_org_title' => $collection_org_title,
			  'collection_note' => $collection_row['collection_note']
			);

			//if ($num_issues) { // is > 0, then add this format to the array
			  array_map("utf8_encode", $collectionInfo);  // new 2015-02-03
			  array_push($collectionArray, $collectionInfo);
			//}//end if

		} //end while collection_row

		$json = array("collectionList" => $collectionArray);
		$encoded = json_encode($json);
		die($encoded);

	}
	mysqli_close($conn);
?>
