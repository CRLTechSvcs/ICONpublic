<?php
	include ("config.php");
	$languagesArray = array();
	$languageQuery = 'SELECT * FROM languages ORDER BY language_name';
	$languageQueryResult = @mysqli_query($conn, $languageQuery) or die( mysqli_error($conn) );
	if (!$languageQueryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($languageQueryResult, MYSQL_ASSOC)) {
			$language_id = $row['language_id'];
			$language_family = $row['language_family'];
			$language_name = $row['language_name'];
			$native_name = $row['native_name'];
			$ISO639_1 = $row['ISO639_1'];
			$ISO639_2B = $row['ISO639_2B'];
			$ISO639_3 = $row['ISO639_3'];
			$language_note = $row['language_note'];

      //HOW MANY PUBS IN THIS LANGUAGE?
			$language_pubs = 0;
      $pubs_query  = 'SELECT COUNT(*) FROM publications WHERE language_id = ?';
      $pubs_statement = $conn->prepare($pubs_query);
      $pubs_statement->bind_param('s', $language_id);
		  $pubs_statement->execute();
		  $pubs_statement->store_result();
			$pubs_statement->bind_result($language_pubs);
		  while($pubs_statement->fetch()) { $language_pubs = $language_pubs; } // end while

        //skip to next language if no pubs from this one: no need to show data about it
		  if ($language_pubs == 0) {
		    continue;
		  }

      //HOW MANY ISSUES FOR THE PUBS IN THIS LANGUAGE?
      $PIDquery = 'SELECT pub_id FROM publications WHERE language_id = ?';
    	$PIDstatement = $conn->prepare($PIDquery);
      $PIDstatement->bind_param('s', $language_id);
      $PIDstatement->execute();
      $PIDstatement->store_result();
      if ($PIDstatement->num_rows > 0){ //got count of pubs for this language_id
        $PIDstatement->bind_result($this_pub_id);
      } //end if

      $all_language_pub_ids = ""; //use this for IN clause in getting issue counts
      while($PIDstatement->fetch()) {
        $all_language_pub_ids .= '"' . $this_pub_id . '", ';
      } //end while
      $all_language_pub_ids = substr($all_language_pub_ids, 0, strlen($all_language_pub_ids) -2); //remove the last comma-space

			$language_issues = 0;
			//echo "<div style='color:#0000ff;'>language: " . $language_id . " " . $language_name . " pubs: " . $all_language_pub_ids . "</div>";
			if ($all_language_pub_ids){ //there are some pubs for this language
    	  $issQuery   = "SELECT COUNT(*) AS language_issues FROM issues WHERE pub_id IN ( " . $all_language_pub_ids . " ) AND issue_date <> '0000-00-00'";
        //echo "<div style='color:#ff0000;'>" . $issQuery . "</div>";
        $issQueryResult = @mysqli_query($conn, $issQuery) or die( "issQuery died with error: " . mysqli_error($conn) );
        while($issRow = mysqli_fetch_array($issQueryResult, MYSQL_ASSOC)) {
          $language_issues = $issRow['language_issues'];
        } // end while issues
      } // end if pubs



        //WHAT ARE THE FIRST + LAST ISSUE DATES FOR THE PUBS IN THIS LANGUAGE?
      $issueDates = $language_id . "-min_max_dates";
      $issueDatesQuery = 'SELECT CAST(CONCAT(MIN(issue_date), " to ", MAX(issue_date)) AS CHAR) AS issue_dates FROM issues ';
      $issueDatesQuery .= 'WHERE pub_id IN ( ' . $all_language_pub_ids . ' ) ';
      $issueDatesQuery .= "AND issue_date <> '0000-00-00'";
    	$issueDatesQueryResult = @mysqli_query($conn, $issueDatesQuery) or die( "issueDatesQuery died with error: on language " . $language_id . "; error ==" . mysqli_error($conn) );
      while($issueDatesRow = mysqli_fetch_array($issueDatesQueryResult, MYSQL_ASSOC)) {
        $issue_dates = $issueDatesRow['issue_dates'];
      } // end while

      //shouldn't have to catch this...
      if($issue_dates == "0000-00-00 to 0000-00-00") { //no valid issues in DB yet
        $issue_dates = "(tbd)";
      }

			$languageInfo = array(
			  "language_id" => $language_id,
        "language_family" => $language_family,
			  "language_name" => $language_name,
        "native_name" => $native_name,
        "ISO639_1" => $ISO639_1,
        "ISO639_2B" => $ISO639_2B,
        "ISO639_3" => $ISO639_3,
        "language_note" => $language_note,
			  "language_pubs" => $language_pubs,
			  "language_issues" => $language_issues,
			  "issue_dates" => $issue_dates
			);
			array_push($languagesArray, $languageInfo);
		} //end while languageQueryResult

    $encoded = json_encode($languagesArray);
		die($encoded);
	}
	$pubs_statement->close();
	$PIDstatement->close();
	mysqli_close($conn);
?>