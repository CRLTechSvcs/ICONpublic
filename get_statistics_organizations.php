<?php
	$orgInfo = array();
	$orgsArray = array();
	include ("config.php");

  /*
    2013-08-12 AJE
    for a report on orgs, we want to know
      1) how many there are
      2) how many states and countries they are in
      3) for each org, how many issues it has in ICON

      modeled somewhat after http://papr-dev.crl.edu/counts/byprogram

  */

	$orgsQuery = "SELECT org_id, org_name, org_street1, org_street2, org_city, country_id, org_postalCode, org_home_uri FROM organizations ORDER BY org_id";

	$queryResult = @mysqli_query($conn, $orgsQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($org_row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$org_id = $org_row['org_id'];
			$org_name = $org_row['org_name'];
			$org_address = $org_row['org_street1'];
			  if ($org_row['org_street2']){ $org_address .= " " . $org_row['org_street2']; }
			$org_city = $org_row['org_city'];
			$country_id = $org_row['country_id']; //country NAME retrieved from ID by get_countries.php + javascripts
			$org_postalCode = $org_row['org_postalCode'];
			$org_home_uri = $org_row['org_home_uri'];

        //HOW MANY PUBS HELD BY THIS ORG?
      $org_pubs    = 0;
      $pubs_query  = 'SELECT COUNT(DISTINCT pub_id) AS org_pubs FROM issues WHERE org_id = ?';
      $pubs_statement = $conn->prepare($pubs_query);
      $pubs_statement->bind_param('s', $org_id);
		  $pubs_statement->execute();
		  $pubs_statement->store_result();
  		if ($pubs_statement->num_rows > 0) { //got count of pubs for this org_id
			  $pubs_statement->bind_result($org_pubs);
		  }//end if
      while($pubs_statement->fetch()) { $org_pubs = $org_pubs; } // end while

        //skip to next repos if no pubs from this one: no need to show data about it
		  if ($org_pubs == 0) {
		    continue;
		  }


      //HOW MANY ISSUES FOR THE PUBS HELD BY THIS ORG?
      $org_issues = 0;
      $issues_query = 'SELECT COUNT(*) AS org_issues FROM issues WHERE org_id = ?';
    	$issues_statement = $conn->prepare($issues_query);
      $issues_statement->bind_param('s', $org_id);
      $issues_statement->execute();
      $issues_statement->store_result();
      if ($issues_statement->num_rows > 0){ //got count of pubs for this org_id
        //$issues_statement->bind_result($this_pub_id);
        $issues_statement->bind_result($org_issues);
      } //end if
      while($issues_statement->fetch()) { $org_issues = $org_issues; } // end while


        //WHAT ARE THE FIRST + LAST ISSUE DATES FOR THE PUBS HELD BY THIS ORG?
      $issueDates = $org_id . "-min_max_dates";
      $issueDatesQuery = 'SELECT CAST(CONCAT(MIN(issue_date), " to ", MAX(issue_date)) AS CHAR) AS issue_dates FROM issues ';
      $issueDatesQuery .= 'WHERE org_id = ? ';
      //$issueDatesQuery .= "AND issue_date <> '0000-00-00'"; // AJE 2016-05-11 zerodate_issues moved to new table
    	$issueDatesStatement = $conn->prepare($issueDatesQuery);
      $issueDatesStatement->bind_param('s', $org_id);
      $issueDatesStatement->execute();
      $issueDatesStatement->store_result();
      if ($issueDatesStatement->num_rows > 0){ //got MIN/MAX issue dates for this org_id
        $issueDatesStatement->bind_result($issue_dates);
      } //end if
      while($issueDatesStatement->fetch()) { $issue_dates = $issue_dates; } // end while

      //shouldn't have to catch this...
      if($issue_dates == "0000-00-00 to 0000-00-00") { //no valid issues in DB yet
        $issue_dates = "(tbd)";
      }

			$orgInfo = array(
			  'org_id' => $org_id,
			  'org_name' => $org_name,
			  'org_address' => $org_address,
			  'org_city' => $org_city,
			  'country_id' => $country_id,
			  'org_postalCode' => $org_postalCode,
			  'org_home_uri' => $org_home_uri,
			  'publications' => $org_pubs,
			  'issues' => $org_issues,
			  'issue_dates' => $issue_dates
			);

			if ($org_pubs) { // is > 0, then add this repository to the array
			  array_push($orgsArray, $orgInfo);
			}//end if
		}//end while
		$encoded = json_encode($orgsArray);
		die($encoded);
	}
	mysqli_close($conn);
?>