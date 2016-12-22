<?php

  /*
    new 2014-09-25
    - triggered by clickable charts on statistics.php
    - which will open display_publications_by_country.php
  */

	include ("config.php");

  $country_id = $_REQUEST['country_id'];
  //echo "country_id: " . $country_id . "<br/>";

  $countryArray = array();

    // pub_country_WHERE_clause handles cases where country_id represents a country composed of multiple codes, like 'United States'
  $pub_country_WHERE_clause = 'WHERE p.country_id ';
  switch ($country_id){
    case 'xxu' : // United States
      $pub_country_WHERE_clause .= "IN ( 'aku', 'alu', 'aru', 'azu', 'cau', 'cou', 'ctu', 'dcu', 'deu', 'flu', 'gau', 'hiu', 'iau', 'idu', 'ilu', 'inu', 'ksu', 'kyu', 'lau', 'mau', 'mdu', 'meu', 'miu', 'mnu', 'mou', 'msu', 'mtu', 'nbu', 'ncu', 'ndu', 'nhu', 'nju', 'nmu', 'nvu', 'nyu', 'ohu', 'oku', 'oru', 'pau', 'riu', 'scu', 'sdu', 'tnu', 'txu', 'utu', 'vau', 'vtu', 'wau', 'wiu', 'wvu', 'wyu', 'xxu' ) ";
      break;
    case 'xxc' : // Canada
      $pub_country_WHERE_clause .= "IN ('abc', 'bcc', 'mbc', 'ncc', 'nfc', 'nkc', 'nsc', 'ntc', 'nuc', 'onc', 'pic', 'quc', 'snc', 'xxc', 'ykc') ";
      break;
    case 'xxk' : // United Kingdom
      $pub_country_WHERE_clause .= "IN ('enk', 'nik', 'stk', 'uik', 'wlk', 'xxk') ";
      break;
    case 'at' : // Australia
      $pub_country_WHERE_clause .= "IN ('aca', 'qea', 'tma', 'vra', 'wea', 'xga', 'xna', 'xoa', 'xra', 'at') ";
      break;
    default : // normal country
      $pub_country_WHERE_clause .= '= "' . $country_id . '" ' ;
  }// end switch


  //$pub_countrySQL = 'SELECT COUNT(1) AS country_count, p.pub_id, p.pub_title, p.pub_city, p.country_id, p.pub_bgnDate, p.pub_endDate, c.country_name ';
  $pub_countrySQL = 'SELECT p.pub_id, p.pub_title, p.pub_city, p.country_id, p.pub_bgnDate, p.pub_endDate, c.country_name ';
  $pub_countrySQL .= 'FROM publications p ';
  $pub_countrySQL .= 'JOIN countries c ON c.country_id = p.country_id ';
  //$pub_countrySQL .= 'WHERE p.country_id = "' . $country_id . '" ' ; // original
  $pub_countrySQL .= $pub_country_WHERE_clause ;
  $pub_countrySQL .= 'ORDER BY p.pub_title, p.pub_city, p.pub_bgnDate';

  //echo "<div style='color:#0000ff;'>pub_countrySQL: <br/> " . $pub_countrySQL . "</div>";

  $countryQueryResult = @mysqli_query($conn, $pub_countrySQL) or die( mysqli_error($conn) );
  //echo "<div style='color:#0000ff;'>query performed</div>";

	if (!$countryQueryResult) {
		echo mysql_error();
	} else {
    //echo "<div style='color:#0000ff;'>country: " . $country_id . " enter while</div>";
		while($row = mysqli_fetch_array($countryQueryResult, MYSQL_ASSOC)) {
			//$country_count = $row['country_count'];
			$pub_id = $row['pub_id'];
			$pub_title = $row['pub_title'];
			$pub_city = $row['pub_city'];
			$pub_bgnDate = $row['pub_bgnDate'];
			$pub_endDate = $row['pub_endDate'];
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


/*
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
			echo "<div style='color:#0000ff;'>country: " . $country_id . " " . $country_name . " pubs: " . $allCountryPubIDs . "</div>";
			if ($allCountryPubIDs){ //there are some pubs for this country
    	  $issQuery   = "SELECT COUNT(*) AS country_issues FROM issues WHERE pub_id IN ( " . $allCountryPubIDs . " ) ';
    	  //$issQuery   .= "AND issue_date <> '0000-00-00'"; // AJE 2016-05-11 zerodate_issues moved to new table
        echo "<div style='color:#ff0000;'>" . $issQuery . "</div>";
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
*/


			$countryInfo = array(
			  //"country_count" => $country_count,
			  "pub_id" => $pub_id,
			  "pub_title" => $pub_title,
			  "pub_city" => $pub_city,
			  "pub_bgnDate" => $pub_bgnDate,
			  "pub_endDate" => $pub_endDate,
			  "country_id" => $country_id,
			  "country_name" => $country_name
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