<?php
	include ("config.php");
	$countriesArray = array();
	$select = 'SELECT * FROM countries ORDER BY country_name';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$countryId = $row['country_id'];
			$countryName = $row['country_name'];
			$countryInfo = array("countryId" => $countryId, "countryName" => $countryName);
			array_push($countriesArray, $countryInfo);
		}
		$encoded = json_encode($countriesArray);
		die($encoded);
	}
	mysqli_close($conn);
?>