<?php
	echo "<html>\n";
	echo "<head>\n";
	echo "<link rel='shortcut icon' href='favicon.ico' type='image/x-icon' />\n";
	echo "<title>Test page load time</title>\n";
	echo "</head>\n";
	echo "<body>\n";
	echo "Testing page load time<br />";
	$time_start = microtime(true);
	$selectedPubId = "sn84023370";
	$i = 0;
	include ("config.php");
	$select = 'SELECT * FROM issues WHERE issue_date <> "0000-00-00" AND pub_id = "' . $selectedPubId . '"';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$i = $i + 1;
			$tempIssueId = $row['issue_id'];
		}
	}
	$time_end = microtime(true);
	$time = $time_end - $time_start;
	mysqli_close($conn);
	echo $i . " issue records retrieved<br />";
	echo "<br />Execution time: " . $time . " seconds";
	echo "</body>\n";
	echo "</html>";
?>