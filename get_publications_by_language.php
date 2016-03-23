<?php

  /*
    new 2014-09-25
    - triggered by clickable charts on statistics.php
    - which will open display_publications_by_language.php
  */

	include ("config.php");

  $language_id = $_REQUEST['language_id'];
  //echo "language_id: " . $language_id . "<br/>";

  $languageArray = array();

  $pub_languageSQL = 'SELECT p.pub_id, p.pub_title, p.pub_city, p.language_id, p.pub_bgnDate, p.pub_endDate, ';
  $pub_languageSQL .= 'L.language_name, c.country_name ';
  $pub_languageSQL .= 'FROM publications p ';
  $pub_languageSQL .= 'JOIN languages L ON L.language_id = p.language_id ';
  $pub_languageSQL .= 'JOIN countries c ON c.country_id = p.country_id ';
  $pub_languageSQL .= 'WHERE p.language_id = "' . $language_id . '" ' ;
  $pub_languageSQL .= 'ORDER BY p.pub_title, p.pub_city, p.pub_bgnDate';

  //echo "<div style='color:#0000ff;'>pub_languageSQL: <br/> " . $pub_languageSQL . "</div>";

  $languageQueryResult = @mysqli_query($conn, $pub_languageSQL) or die( mysqli_error($conn) );
  //echo "<div style='color:#0000ff;'>query performed</div>";

	if (!$languageQueryResult) {
		echo mysql_error();
	} else {
    //echo "<div style='color:#0000ff;'>language: " . $language_id . " enter while</div>";
		while($row = mysqli_fetch_array($languageQueryResult, MYSQL_ASSOC)) {
			//$language_count = $row['language_count'];
			$pub_id = $row['pub_id'];
			$pub_title = $row['pub_title'];
			$pub_city = $row['pub_city'];
			$pub_country = $row['country_name'];
			$pub_bgnDate = $row['pub_bgnDate'];
			$pub_endDate = $row['pub_endDate'];
			$language_id = $row['language_id'];
			$language_name = $row['language_name'];

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

			$languageInfo = array(
			  //"language_count" => $language_count,
			  "pub_id" => $pub_id,
			  "pub_title" => $pub_title,
			  "pub_city" => $pub_city,
			  "pub_country" => $pub_country,
			  "pub_bgnDate" => $pub_bgnDate,
			  "pub_endDate" => $pub_endDate,
			  "language_id" => $language_id,
			  "language_name" => $language_name
			);
			array_push($languageArray, $languageInfo);
		} //end while languageQueryResult

    $encoded = json_encode($languageArray);
		die($encoded);
	}
	$pubs_statement->close();
	$PIDstatement->close();
	mysqli_close($conn);
?>