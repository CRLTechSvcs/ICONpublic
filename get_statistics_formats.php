<?php
	$formatInfo = array();
	$formatArray = array();
	include ("config.php");

  /*
    2013-09-24 AJE
    for a report on formats, we want to know
      1) how many there are
      2) how many pubs are in each
      3) for each pub-format, how many issues it has in ICON
I just decided on all that, so this file may not do it all because I'm rushed!

      modeled somewhat after http://papr-dev.crl.edu/counts/byprogram

  */

	$formatQuery = "SELECT format_id, format_name, format_note FROM formats";

	$queryResult = @mysqli_query($conn, $formatQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($format_row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$format_id = $format_row['format_id'];
			$format_name = $format_row['format_name'];
			$format_note = $format_row['format_note'];

        //HOW MANY PUBS FOR THIS FORMAT?
      $num_pubs    = 0;
      $pubs_query  = 'SELECT COUNT(DISTINCT pub_id) as num_pubs FROM issues WHERE format_id = ?';
      $pubs_statement = $conn->prepare($pubs_query);
      $pubs_statement->bind_param('s', $format_id);
		  $pubs_statement->execute();
		  $pubs_statement->store_result();
  		if ($pubs_statement->num_rows > 0) { //got count of pubs for this format_id
			  $pubs_statement->bind_result($num_pubs);
		  }//end if
      while($pubs_statement->fetch()) { $num_pubs = $num_pubs; } // end while

      //HOW MANY ISSUES FOR THE PUBS IN THIS FORMAT?
      $num_issues = 0;
      $issues_query = 'SELECT COUNT(*) as num_issues FROM issues WHERE format_id = ?';
    	$issues_statement = $conn->prepare($issues_query);
      $issues_statement->bind_param('s', $format_id);
      $issues_statement->execute();
      $issues_statement->store_result();
      if ($issues_statement->num_rows > 0){ //got count of pubs for this format_id
        $issues_statement->bind_result($num_issues);
      } //end if
      while($issues_statement->fetch()) { $num_issues = $num_issues; } // end while

      //echo '<p>format_id = ' . $format_id . ', format_name = ' . $format_name . ', publications = ' . $num_pubs . ', issues = ' . $num_issues . '</p>';

			$formatInfo = array(
			  'format_id' => $format_id,
			  'format_name' => $format_name,
			  'format_note' => $format_note,
			  'publications' => $num_pubs,
			  'issues' => $num_issues
			);

			if ($num_issues) { // is > 0, then add this format to the array
			  array_push($formatArray, $formatInfo);
			}//end if
		}//end while
		//$json = array("formats" => $formatArray);
		$encoded = json_encode($formatArray);
		die($encoded);
	}
	mysqli_close($conn);
?>