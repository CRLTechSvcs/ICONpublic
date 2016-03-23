<?php

	$pub_info = array();
	$org_pubs_array = array();
	include ("config.php");

  $org_id = $_REQUEST['org_id'];
  //echo "org_id: " . $org_id . "<br/>";

  /*
    2013-08-12 AJE
    for a report on orgs, we want to know
      1) how many there are
      2) how many states and countries they are in
      3) for each org, how many issues it has in ICON

      modeled somewhat after http://papr-dev.crl.edu/counts/byprogram

    2014-09-30 based on get_statistics_organizations.php
      //HOW MANY PUBS HELD BY THIS ORG? get_statistics_organizations_static.php fills that for us, we have it in the javsscript orgsArray
      //HOW MANY ISSUES FOR THE PUBS HELD BY THIS ORG? same again: it's in the javascript
      //WHAT ARE THE FIRST + LAST ISSUE DATES FOR THE PUBS HELD BY THIS ORG? see javascript
    what we need here are basic details of the publications held by this org.
    1) get all the pub_ids
    2) similar to get_publications_by_country.php, want those fields


  */


// Sort the multidimensional array: solution from nick ([AT]) nickyost ([DOT]) com in the PHP manual
function custom_sort($a,$b) { // Define the custom sort function
     return $a['pub_title']>$b['pub_title'];
}


  // 1) get all the pub_ids
	//$orgs_pub_id_SQL = 'SELECT DISTINCT pub_id FROM issues WHERE org_id = "' . $org_id . '"';
	$orgs_pub_id_SQL = 'SELECT DISTINCT pub_id FROM C3publications_per_org WHERE org_id = "' . $org_id . '"';
  //echo '<br/>orgs_pub_id_SQL = ' . $orgs_pub_id_SQL . ';';

	$orgs_pub_id_result = @mysqli_query($conn, $orgs_pub_id_SQL) or die( mysqli_error($conn) );
	$org_pubs_count = mysqli_num_rows($orgs_pub_id_result);
	//echo 'org_pubs_count = ' . $org_pubs_count;
	if (!$orgs_pub_id_result) {
		echo mysql_error();
	} else {
	  //echo '<br/>there were ' . $org_pubs_count . ' results';
		while($pub_id_row = mysqli_fetch_array($orgs_pub_id_result, MYSQL_ASSOC)) {

      $this_pub_SQL = 'SELECT p.pub_id, p.pub_title, p.pub_city, p.country_id, p.pub_bgnDate, p.pub_endDate, c.country_name ';
      $this_pub_SQL .= 'FROM publications p ';
      $this_pub_SQL .= 'JOIN countries c ON c.country_id = p.country_id ';
      $this_pub_SQL .= 'WHERE p.pub_id = "' . $pub_id_row['pub_id'] . '"';
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

  			$pub_info = array(
  			  'org_id' => $org_id,
  			  'pub_id' => $pub_id,
  			  'pub_title' => $pub_title,
  			  'pub_city' => $pub_city,
  			  'pub_bgnDate' => $pub_bgnDate,
  			  'pub_endDate' => $pub_endDate,
  			  'country_id' => $country_id,
  			  'country_name' => $country_name
  			);

        array_push($org_pubs_array, $pub_info);
      }//end while: each pub
    } // end while pub_id_row

    usort($org_pubs_array, "custom_sort"); // call custom sort function

		$encoded = json_encode($org_pubs_array);
		die($encoded);

  }// end else: there were results
	mysqli_close($conn);
?>