<?php

	$thisPub_id = str_replace("%20", "", $_REQUEST['pub_id']);//strip spaces out of the pub_id passed in from bib rec

	include ("config.php");

  // AJE 2015-07-27 added language fields
  $select = 'SELECT p.*, country_name, b_showFullText, ref_data_uri, ref_data_body, ref_data_title, ref_source_title, language_name, native_name ';
	$select .= 'FROM publications p ';
	$select .= 'JOIN countries c USING (country_id) ';
	$select .= 'JOIN languages L USING (language_id) ';
	$select .= 'LEFT JOIN reference_linkage rl USING (pub_id ) ';
	$select .= 'LEFT JOIN reference_data rd USING (ref_data_id) ';
	$select .= 'LEFT JOIN reference_sources rs USING (ref_source_id) ';
	$select .= 'WHERE pub_id = "' . $thisPub_id . '"';
  //echo $select . '<br/>';

  $json = "";

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	//echo "<h3>numrows=" . $numrows . " for pub_id " . $thisPub_id .  "</h3>";
	if (!$queryResult) {
		echo mysql_error();
	} else { //this while should actually last just one iteration: only 1 pub per id!
	  while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
  	 $json = array(
  	  "pubId" => trim($row["pub_id"]),
      "ISSN" => trim($row["ISSN"]),
      "OCLC" => trim($row["OCLC"]),
      "marc001" => trim($row["marc001"]),
      "pubTitle" => trim($row["pub_title"]),
      "pubTitleAlt" => trim($row["pub_title_alt"]),
  		"pubCity" =>trim($row["pub_city"]),
      "countryId" => trim($row["country_id"]),
      "countryName" => trim($row["country_name"]),
      "pubFreqIdCode" => trim($row["freq_id_code"]),
  		"pubBgnDate" => trim($row["pub_bgnDate"]),  //pub_bgnDate and pub_bgnDate are sort of junk fields that did not necessarily come from the bib data
      "pubEndDate" => trim($row["pub_endDate"]),
      "date260C" => trim($row["date260C"]),
      "date362" => trim($row["date362"]),
      "frequency310" => trim($row["frequency310"]),
  		"formerFrequency321" => trim($row["formerFrequency321"]),
      "language_id" => trim($row["language_id"]),
      "language_name" => trim($row["language_name"]),
      "native_name" => trim($row["native_name"]),
      "numberingNote515" => trim($row["numberingNote515"]),
  		"summary520" => trim($row["summary520"]),
  		"descriptionNote588" => trim($row["descriptionNote588"]),
  		"bib_relationships" => trim($row["bib_relationships"]),
  		"refDataBody" => trim($row["ref_data_body"]),
      "refDataTitle" => trim($row["ref_data_title"]),
  		"refDataURI" => trim($row["ref_data_uri"]),
      "refSourceTitle" => trim($row["ref_source_title"]),
      "showFullText" => trim($row["b_showFullText"]));
    }//end while
  }// end else
	 $encoded = json_encode($json);
	 die($encoded);
	 mysqli_close($conn);
?>