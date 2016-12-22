<?php
/*
  This script by Constance Jurczyk, ca. 2012
    - gets information about the formats that one publication has issues for in ICON database.

  AJE 2013-11-11
    - revised to also retrieve the number of issues in each format for that one publication
    - CJ's original JSON structure was like:
      {"formatList":["Microfilm","Microopaque","Original","Paper"]}

    - now new setup:
      - formatInfo is the data for any single format
      - formatArray is the final product, array of the individual formatInfo pieces, converted to JSON and returned
*/

	$selectedPubId = $_REQUEST['selectedPubId'];
	$formatInfo = array();
	$formatArray = array();
	include ("config.php");

  /*
	$select  = 'SELECT DISTINCT f.format_id, f.format_name, f.format_note FROM formats f, issues i WHERE i.format_id = f.format_id AND ';
	$select .= 'i.pub_id = "' . $selectedPubId . '"';
  */

	$formatQuery  = 'SELECT f.format_id AS format_id, f.format_name AS format_name, f.format_note AS format_note ';
	$formatQuery .= 'FROM formats f WHERE f.format_id IN ( ';
	  $formatQuery .= 'SELECT DISTINCT(format_id) FROM issues ';
	  $formatQuery .= 'WHERE pub_id = "'. $selectedPubId . '" ';
	  //$formatQuery .= 'AND issue_date != "0000-00-00" '; // AJE 2016-05-11 zerodate_issues moved to new table
  $formatQuery .= ') ORDER BY f.format_name';
	$formatResult = @mysqli_query($conn, $formatQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($formatResult);
	if (!$formatResult) {
		echo mysql_error();
	} else {
    while($format_row = mysqli_fetch_array($formatResult, MYSQL_ASSOC)) {

			$format_id = $format_row['format_id'];
			$format_name = $format_row['format_name'];
			// AJE 2015-01-28 -- changed the format_name field in the database so no need for big ifs that were here
			$format_note = $format_row['format_note'];

      //HOW MANY ISSUES FOR THE PUBS IN THIS FORMAT?
      $num_issues = 0;
      $issues_query = 'SELECT COUNT(*) as num_issues FROM issues ';
      $issues_query .= 'WHERE issues.pub_id = "'. $selectedPubId . '" ';
      $issues_query .= 'AND format_id = ' . $format_id . ' ';
      //$issues_query .= 'AND issues.issue_date != "0000-00-00" '; // AJE 2016-05-11 zerodate_issues moved to new table
      //echo $issues_query;
    	$issues_statement = $conn->prepare($issues_query);
      //$issues_statement->bind_param('s', $format_id);
      $issues_statement->execute();
      $issues_statement->store_result();
      if ($issues_statement->num_rows > 0){ //got count of pubs for this format_id
        $issues_statement->bind_result($num_issues);
      } //end if
      while($issues_statement->fetch()) { $num_issues = $num_issues; } // end while

			$formatInfo = array(
			  'format_id' => $format_id,
			  'formatName' => $format_name,   // version for CJ's function displayFormatList in calendar_selection_functions.js
			  'format_name' => $format_name,  // for AJE Google Chart API script
			  'format_note' => $format_note,
			  'publications' => "1",
			  'issues' => $num_issues
			);

			if ($num_issues) { // is > 0, then add this format to the array
			  array_map("utf8_encode", $formatInfo);  // new 2015-02-03
			  array_push($formatArray, $formatInfo);
			}//end if

		} //end while format_row

		$json = array("formatList" => $formatArray);
		$encoded = json_encode($json);
		die($encoded);

	}
	mysqli_close($conn);
?>