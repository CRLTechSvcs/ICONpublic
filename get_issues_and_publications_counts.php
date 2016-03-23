<?php
	include ("config.php");

  $pubIssInfo = array();
  $pubIssArray = array();

  $countPublicationsQuery = "SELECT COUNT(*) AS countPubs FROM publications";
  $countIssuesQuery = "SELECT COUNT(*) AS countIssues FROM issues";

	$pubsQueryResult = @mysqli_query($conn, $countPublicationsQuery) or die( mysqli_error($conn) );
	if (!$pubsQueryResult) {
		echo mysql_error();
	} else {
	  $countPubs = 0;
		while($pubs_row = mysqli_fetch_array($pubsQueryResult, MYSQL_ASSOC)) {
			$countPubs = $pubs_row['countPubs'];
    }//end while
  }//end if


	$issuesQueryResult = @mysqli_query($conn, $countIssuesQuery) or die( mysqli_error($conn) );
	if (!$issuesQueryResult) {
		echo mysql_error();
	} else {
	  $countIssues = 0;
		while($issues_row = mysqli_fetch_array($issuesQueryResult, MYSQL_ASSOC)) {
			$countIssues = $issues_row['countIssues'];
    }//end while
  }//end if


  $pubIssInfo = array(
    'countPubs' => $countPubs,
    'countIssues' => $countIssues
  );

  array_push($pubIssArray, $pubIssInfo);
  $encoded = json_encode($pubIssArray);
	die($encoded);
	mysql_close($conn);

?>