<?php
	include ("config.php");
	$languagesArray = array();
	$select = 'SELECT * FROM languages ';
	$select .= 'WHERE language_id IN ( SELECT DISTINCT language_id FROM publications)';
	$select .= 'ORDER BY language_name, native_name';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$language_id = $row['language_id'];
			$language_family = $row['language_family'];
			$language_name = $row['language_name'];
			$native_name = $row['native_name'];
			$ISO639_1 = $row['ISO639_1'];
			$ISO639_2B = $row['ISO639_2B'];
			$ISO639_3 = $row['ISO639_3'];
			$language_note = $row['language_note'];

			$languageInfo = array(
			  "language_id" => $language_id,
        "language_family" => $language_family,
			  "language_name" => $language_name,
        "native_name" => $native_name,
        "ISO639_1" => $ISO639_1,
        "ISO639_2B" => $ISO639_2B,
        "ISO639_3" => $ISO639_3,
        "language_note" => $language_note
			);

			array_push($languagesArray, $languageInfo);
		}
		$encoded = json_encode($languagesArray);
		die($encoded);
	}
	mysqli_close($conn);
?>