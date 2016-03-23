<?php
/*
  AJE 2015-02-06
  - this script is called from function populateStaticOrganizations in calendar_selection_functions.js
  - gets the number of issues for a publication
  - gets minimum and maximum date for a publication
  - uses A1issues_per_publication_output (special lookup table) to avoid using issues table
  - needs pub_id as input
*/

	$pub_id  = $_REQUEST['selectedPubId'];
	include ("config.php");

  $this_sql = 'SELECT issue_count_valid, issue_count_distinct, MINVALIDissue_date, MAXVALIDissue_date ';
  $this_sql .= 'FROM A1issues_per_publication ';
  $this_sql .= 'WHERE pub_id = "' . $pub_id . '" ';

  //echo $this_sql;

  $this_statement = $conn->prepare($this_sql);
  $this_statement->execute();
  $this_statement->store_result();
  if ($this_statement->num_rows > 0){ //got count of pubs for this org_id
    $this_statement->bind_result(
      $issue_count_valid, $issue_count_distinct, $MINVALIDissue_date, $MAXVALIDissue_date
    );
    while($this_statement->fetch()) {
    $issue_count_valid = $issue_count_valid;
    $issue_count_distinct = $issue_count_distinct;
    $MINVALIDissue_date = $MINVALIDissue_date;
    $MAXVALIDissue_date = $MAXVALIDissue_date;
    } // end while
    $pub_issue_data = array(
      'issue_count_valid' => $issue_count_valid,
      'issue_count_distinct' => $issue_count_distinct,
      'MINVALIDissue_date' => $MINVALIDissue_date,
      'MAXVALIDissue_date' => $MAXVALIDissue_date
    );

    array_map("utf8_encode", $pub_issue_data);  // new 2015-02-03
		$encoded = json_encode($pub_issue_data);

		die($encoded);
	}
	mysqli_close($conn);
?>