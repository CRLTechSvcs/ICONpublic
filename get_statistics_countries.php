<?php
	include ("config.php");
	$countryArray = array();
	$countryQuery = 'SELECT * FROM countries ORDER BY country_name';
	$countryQueryResult = @mysqli_query($conn, $countryQuery) or die( mysqli_error($conn) );
	if (!$countryQueryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($countryQueryResult, MYSQL_ASSOC)) {
			$country_id = $row['country_id'];
			$country_name = $row['country_name'];

      //HOW MANY PUBS IN THIS COUNTRY?
			$country_pubs = 0;
      $pubs_query  = 'SELECT COUNT(*) FROM publications WHERE country_id = ?';
      $pubs_statement = $conn->prepare($pubs_query);
      $pubs_statement->bind_param('s', $country_id);
		  $pubs_statement->execute();
		  $pubs_statement->store_result();
			$pubs_statement->bind_result($country_pubs);
		  while($pubs_statement->fetch()) { $country_pubs = $country_pubs; } // end while

        //skip to next country if no pubs from this one: no need to show data about it
		  if ($country_pubs == 0) {
		    continue;
		  }

      //HOW MANY ISSUES FOR THE PUBS IN THIS COUNTRY?
      $PIDquery = 'SELECT pub_id FROM publications WHERE country_id = ?';
    	$PIDstatement = $conn->prepare($PIDquery);
      $PIDstatement->bind_param('s', $country_id);
      $PIDstatement->execute();
      $PIDstatement->store_result();
      if ($PIDstatement->num_rows > 0){ //got count of pubs for this country_id
        $PIDstatement->bind_result($this_pub_id);
      } //end if

      $allCountryPubIDs = ""; //use this for IN clause in getting issue counts
      while($PIDstatement->fetch()) {
        $allCountryPubIDs .= '"' . $this_pub_id . '", ';
      } //end while
      $allCountryPubIDs = substr($allCountryPubIDs, 0, strlen($allCountryPubIDs) -2); //remove the last comma-space

			$country_issues = 0;
			//echo "<div style='color:#0000ff;'>country: " . $country_id . " " . $country_name . " pubs: " . $allCountryPubIDs . "</div>";
			if ($allCountryPubIDs){ //there are some pubs for this country
    	  $issQuery   = "SELECT COUNT(*) AS country_issues FROM issues WHERE pub_id IN ( " . $allCountryPubIDs . " ) ";
    	  //$issQuery   .= "AND issue_date <> '0000-00-00'"; // AJE 2016-05-11 zerodate_issues moved to new table
        //echo "<div style='color:#ff0000;'>" . $issQuery . "</div>";
        $issQueryResult = @mysqli_query($conn, $issQuery) or die( "issQuery died with error: " . mysqli_error($conn) );
        while($issRow = mysqli_fetch_array($issQueryResult, MYSQL_ASSOC)) {
          $country_issues = $issRow['country_issues'];
        } // end while issues
      } // end if pubs



        //WHAT ARE THE FIRST + LAST ISSUE DATES FOR THE PUBS IN THIS COUNTRY?
      $issueDates = $country_id . "-min_max_dates";
      $issueDatesQuery = 'SELECT CAST(CONCAT(MIN(issue_date), " to ", MAX(issue_date)) AS CHAR) AS issue_dates FROM issues ';
      $issueDatesQuery .= 'WHERE pub_id IN ( ' . $allCountryPubIDs . ' ) ';
      //$issueDatesQuery .= "AND issue_date <> '0000-00-00'"; // AJE 2016-05-11 zerodate_issues moved to new table
    	$issueDatesQueryResult = @mysqli_query($conn, $issueDatesQuery) or die( "issueDatesQuery died with error: on country " . $country_id . "; error ==" . mysqli_error($conn) );
      while($issueDatesRow = mysqli_fetch_array($issueDatesQueryResult, MYSQL_ASSOC)) {
        $issue_dates = $issueDatesRow['issue_dates'];
      } // end while

      //shouldn't have to catch this...
      if($issue_dates == "0000-00-00 to 0000-00-00") { //no valid issues in DB yet
        $issue_dates = "(tbd)";
      }



			$countryInfo = array(
			  "country_id" => $country_id,
			  "country_name" => $country_name,
			  "country_pubs" => $country_pubs,
			  "country_issues" => $country_issues,
			  "issue_dates" => $issue_dates
			);
			array_push($countryArray, $countryInfo);
		} //end while countryQueryResult

    $encoded = json_encode($countryArray);
		die($encoded);
	}
	$pubs_statement->close();
	$PIDstatement->close();
	mysqli_close($conn);
?>