<?php
/*
  2015-07-29
  for display_publications_by_language.php (at least)

  - submit a language_id, get a JSON of all the countries where ICON has some pubs in that language

*/

	include ("config.php");

	$language_countries = array();

	if (isset($_REQUEST['language_id'])) {
  	$this_lang_id = $_REQUEST['language_id'];
  } else $this_lang_id = 'zxx';

  $select = 'SELECT DISTINCT L.language_id, L.language_name, p.country_id, c.country_name ';
  $select .= 'FROM languages L ';
  $select .= 'JOIN publications p ON p.language_id = L.language_id ';
  $select .= 'JOIN countries c ON c.country_id = p.country_id ';
  //$select .= 'WHERE L.language_id IN (SELECT DISTINCT p.language_id FROM publications p) ';
  $select .= 'WHERE L.language_id = "' . $this_lang_id . '" ';
  $select .= 'ORDER BY L.language_name';

  //echo '<br/>' . $select . '<br/>';

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$language_id = $row['language_id'];
			$language_name = $row['language_name'];
			$country_id = $row['country_id'];
			$country_name = $row['country_name'];

		        //HOW MANY PUBS IN THIS COUNTRY?
			$num_pubs_in_country = 0;
      $pubs_query  = 'SELECT COUNT(*) FROM publications WHERE country_id = ? ';
      $pubs_query .= 'AND language_id = ?';
      $pubs_statement = $conn->prepare($pubs_query);
      $pubs_statement->bind_param('ss', $country_id, $language_id);
		  $pubs_statement->execute();
		  $pubs_statement->store_result();
			$pubs_statement->bind_result($num_pubs_in_country);

		  while($pubs_statement->fetch()) { $num_pubs_in_country = $num_pubs_in_country; } // end while
			$country_info = array(
			  //"language_id" => $language_id, "language_name" => $language_name,
			  "country_id" => $country_id, "country_name" => $country_name,
			  "country_pubs" => $num_pubs_in_country
			);
			array_push($language_countries, $country_info);
		}
		$encoded = json_encode($language_countries);
		die($encoded);
	}
	mysqli_close($conn);
?>