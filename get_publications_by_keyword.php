<?php

	include ("config.php");
	//Initialize searchterm parameters
	$keyword_parameter = '';
	//Initialize other variables
	$titleArray = array();
	$whereArray = array();

	//Capture searchterm parameter values and append fields to WHERE clause
	if ( isset($_REQUEST['keyword']) && (strlen($_REQUEST['keyword']) > 0)) {
    $keyword_parameter = $_REQUEST['keyword'];
    $keywordWhere = ' (pub_title LIKE "%' . $keyword_parameter . '%" ' .
    'OR pub_title_alt LIKE "%' . $keyword_parameter . '%" ' .
    'OR pub_id LIKE "%' . $keyword_parameter . '%" ' .
    'OR OCLC LIKE "%' . $keyword_parameter . '%" ' .
    'OR ISSN LIKE "%' . $keyword_parameter . '%" ' .
    'OR pub_city LIKE "%' . $keyword_parameter . '%" ' .
    'OR country_name LIKE "%' . $keyword_parameter . '%" ' .
    'OR numberingNote515 LIKE "%' . $keyword_parameter . '%" ' .
    'OR summary520 LIKE "%' . $keyword_parameter . '%" ' .
    'OR descriptionNote588 LIKE "%' . $keyword_parameter . '%" ' .
    'OR pub_note LIKE "%' . $keyword_parameter . '%") ';
    array_push($whereArray, $keywordWhere);
	}
	$whereClause = implode("AND", $whereArray);

	$select = 'SELECT p.*, country_name, language_name, native_name ';
	$select .= 'FROM publications p ';
	$select .= 'JOIN countries c USING (country_id) ';
	$select .= 'JOIN languages L USING (language_id) ';
	$select .= 'WHERE';
	$select .= $whereClause;
  //echo '<hr/>'. $select . '<hr/>';

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysql_error();
	} else {
		$num_records = mysqli_num_rows($queryResult);
		if ($num_records > 0) {
			if ($num_records < 500) {
				while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
					$titleInfo = array(
					  "pub_id" => trim($row['pub_id']),
						 "ISSN" => trim($row['ISSN']),
						 "OCLC" => trim($row['OCLC']),
						 "marc001" => trim($row['marc001']),
						 "pub_title" => trim($row['pub_title']),
						 "pub_title_alt" => trim($row['pub_title_alt']),
						 "pub_city" => trim($row['pub_city']),
						 "country_id" => trim($row['country_id']),
						 "pub_bgnDate" => trim($row['pub_bgnDate']),
						 "pub_endDate" => trim($row['pub_endDate']),
						 "date260C" => trim($row['date260C']),
						 "date362" => trim($row['date362']),
						 "freq_id_code" => trim($row['freq_id_code']),
						 "frequency310" => trim($row['frequency310']),
						 "former_freq_id_code" => trim($row['former_freq_id_code']),
						 "formerFrequency321" => trim($row['formerFrequency321']),
						 "language_id" => trim($row['language_id']),
						 "numberingNote515" => trim($row['numberingNote515']),
						 "summary520" => trim($row['summary520']),
						 "descriptionNote588" => trim($row['descriptionNote588']),
						 "bib_relationships" => trim($row['bib_relationships']),
						 "link856" => trim($row['link856']),
						 "pubNote" => trim($row['pub_note']),
						 "country_name" => trim($row['country_name']),
             "language_name" => trim($row['language_name']),
             "native_name" => trim($row['native_name'])
					);
					array_push($titleArray, $titleInfo);
				}

      	//CFJ 10/9/14 1:03PM
      	//Sort title array by title field, then by city field.
      	//Solution from http://us2.php.net/array_multisort
      	foreach ($titleArray as $key => $row) {
          $title[$key]  = $row['pub_title'];
          $city[$key] = $row['pub_city'];
      	}
      	array_multisort($title, SORT_ASC, $city, SORT_ASC, $titleArray);

      //begin AJE test: 2013-06-21 14:25:52
      	$encoded = json_encode($titleArray);
      	setcookie("lastSQLquery", urlencode($select));
      	die($encoded);
      //end AJE test
    	} else { // num_records > 500
    	  echo "Too many titles to display";
    	}
  	} else {
  		echo "No results returned";
  	}
	} // end if there was no error

	 mysqli_close($conn);
?>