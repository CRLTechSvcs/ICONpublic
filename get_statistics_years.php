<?php
	$yearInfo = array();
	$yearsArray = array();
	include ("config.php");

  /*
    2013-08-12 AJE
    for a report on years, modeling after http://papr-dev.crl.edu/counts/byyear
  */


  $year_query = 'SELECT DISTINCT LEFT( CAST(issue_date AS CHAR), 4) AS yearPortion FROM issues';
	$year_result = @mysqli_query($conn, $year_query) or die( mysqli_error($conn) );
	$num_years = mysqli_num_rows($year_result);
	if (!$year_result) {
		echo mysql_error();
	} else {
		while($year_row = mysqli_fetch_array($year_result, MYSQL_ASSOC)) {
			$this_year = $year_row['yearPortion'];

      $year_pubs    = "year_pubs"; //fake
      $pubs_query    = 'SELECT COUNT(DISTINCT pub_id) AS year_pubs FROM issues WHERE LEFT( CAST(issues.issue_date AS CHAR), 4) = ?';
      $pubs_statement = $conn->prepare($pubs_query);
      $pubs_statement->bind_param('s', $this_year);
		  $pubs_statement->execute();
		  $pubs_statement->store_result();
		  $pubs_statement->bind_result($year_pubs);
      while($pubs_statement->fetch()) { $year_pubs = $year_pubs; } // end while

      $year_issues    = "year_issues"; //fake
      $issues_query    = 'SELECT COUNT(DISTINCT issue_id) AS year_issues FROM issues WHERE LEFT( CAST(issues.issue_date AS CHAR), 4) = ?';
      $issues_statement = $conn->prepare($issues_query);
      $issues_statement->bind_param('s', $this_year);
		  $issues_statement->execute();
		  $issues_statement->store_result();
		  $issues_statement->bind_result($year_issues);
      while($issues_statement->fetch()) { $year_issues = $year_issues; } // end while

			$yearInfo = array(
			  'this_year' => $this_year,
			  'year_pubs' => $year_pubs,
			  'year_issues' => $year_issues
			);

			if ($year_issues) { // is > 0, then add this year to the array
			  array_push($yearsArray, $yearInfo);
			}//end if
		}//end while
		$encoded = json_encode($yearsArray);
		die($encoded);
	}
	mysqli_close($conn);
?>