<?php

	include ("config.php");

	//Initialize publications table fields
	/*
	// AJE 2015-07-27 : fill directly from database output
	$str_pub_id              = '';
	$str_ISSN                = '';
	$str_OCLC                = '';
	$str_marc001             = '';
	$str_pub_title           = '';
	$str_pub_title_alt       = '';
	$str_pub_city            = '';
	$str_country_id          = '';
	$str_pub_bgnDate         = '';
	$str_pub_endDate         = '';
	$str_date260C            = '';
	$str_date362             = '';
	$str_freq_id_code        = '';
	$str_frequency310        = '';
	$str_former_freq_id_cods = '';
	$str_formerFrequency321  = '';
	$str_language_id         = '';
	$str_numberingNote515    = '';
	$str_summary520          = '';
	$str_descriptionNote588  = '';
	$str_link856             = '';
	$str_pub_note            = '';
	$str_country_name        = '';
	$str_showFullText        = '';
	$str_ref_data_uri        = '';
	$str_ref_data_body       = '';
	$str_ref_data_title      = '';
	$str_ref_source_title    = '';
  */

	//Initialize searchterm parameters
	$title_parameter = '';
	$lccn_parameter = '';
	$oclc_parameter = '';
	$issn_parameter = '';
	$city_parameter = '';
	$keyword_parameter = '';
	$state_country_parameter = '';
	$state_country_name_parameter = '';
	$language_parameter = ''; // AJE 2015-07-27

	//Initialize other variables
	//$foundInField = 'none'; // not used: AJE 2015-07-27 14:30:14
	$titleArray = array();
	//$pubIdArray = array(); // not used: AJE 2015-07-27 14:30:14
	$whereArray = array();
	//$json = array(); // not used: AJE 2015-07-27 14:30:14


	//Capture searchterm parameter values and append fields to WHERE clause
	if (isset($_REQUEST['title'])) {
    $title_parameter = $_REQUEST['title'];
    if (strlen($title_parameter) > 0) {
    	if ($title_parameter == 'Title' || $title_parameter == 'title') {
    		//If title search term is simply the word 'title', don't search pub_title_alt field (where 'title' often appears in a different context)
    		array_push($whereArray, ' pub_title LIKE "%' . $title_parameter . '%" ');
    	} else {
    		array_push($whereArray, ' (pub_title LIKE "%' . $title_parameter . '%" OR pub_title_alt LIKE "%' . $title_parameter . '%") ');
    	}
  	}
	}
	if (isset($_REQUEST['lccn'])) {
    $lccn_parameter = $_REQUEST['lccn'];
    $lccn_parameter = str_replace("%20", "", $lccn_parameter);//strip spaces
    if (strlen($lccn_parameter) > 0) {
    	array_push($whereArray, ' (pub_id LIKE "%' . $lccn_parameter . '%" OR marc001 LIKE "%' . $lccn_parameter . '%") ');
    }
	}
	if (isset($_REQUEST['oclc'])) {
    $oclc_parameter = $_REQUEST['oclc'];
    if (strlen($oclc_parameter) > 0) {
    	array_push($whereArray, ' (OCLC LIKE "%' . $oclc_parameter . '%" OR marc001 LIKE "%' . $oclc_parameter . '%") ');
    }
	}
	if (isset($_REQUEST['issn'])) {
    $issn_parameter = $_REQUEST['issn'];
    if (strlen($issn_parameter) > 0) {
    	array_push($whereArray, ' ISSN LIKE "%' . $issn_parameter . '%" ');
    }
	}
	if (isset($_REQUEST['city'])) {
    $city_parameter = $_REQUEST['city'];
    if (strlen($city_parameter) > 0) {
    	array_push($whereArray, ' pub_city LIKE "%' . $city_parameter . '%" ');
    }
	}
	if (isset($_REQUEST['state_country_name'])) {
		//User entered search term on basic search page
    $state_country_name_parameter = $_REQUEST['state_country_name'];
    if (strlen($state_country_name_parameter) > 0) {
    	//array_push($whereArray, ' country_name LIKE "%' . $state_country_name_parameter . '%" ');
    	array_push($whereArray, ' c.country_name LIKE "%' . $state_country_name_parameter . '%" ');
    }
	}
	if (isset($_REQUEST['state_country'])) {
		//User selected state or country on advanced search page
    $state_country_parameter = $_REQUEST['state_country'];
    if (!($state_country_parameter == "0")) {
    	//A state/country was selected from dropdown
    	if (strlen($state_country_parameter) > 0) {
    		//array_push($whereArray, ' country_id = "' . $state_country_parameter . '" ');
    		array_push($whereArray, ' p.country_id = "' . $state_country_parameter . '" ');
    	}
  	}
	}
	//if (isset($_REQUEST['keyword'])) {
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
    'OR descriptionNote588 LIKE "%' . $keyword_parameter . '%") ';
    array_push($whereArray, $keywordWhere);
	}

	if (isset($_REQUEST['from_year'])) {
    $from_year_parameter = $_REQUEST['from_year'];
    if (strlen($from_year_parameter) > 0) {
    	array_push($whereArray, ' pub_bgnDate >= "' . $from_year_parameter . '" AND pub_bgnDate REGEXP "^[0-9]{4}$" ');
    }
	}
	if (isset($_REQUEST['to_year'])) {
    $to_year_parameter = $_REQUEST['to_year'];
    if (strlen($to_year_parameter) > 0) {
    	array_push($whereArray, ' pub_endDate <= "' . $to_year_parameter . '" AND pub_endDate REGEXP "^[0-9]{4}$" ');
    }
	}
	// AJE new 2015-07-27
  //echo 'isset search_language? == ' . isset($_REQUEST['search_language'])	. '.<br/>';
	if (isset($_REQUEST['search_language'])) {
    $language_parameter = $_REQUEST['search_language'];
    if (strlen($language_parameter) > 0) {
    	array_push($whereArray, ' p.language_id = "' . $language_parameter . '" ');
    }
	}
	//end AJE new 2015-07-27

	$whereClause = implode("AND", $whereArray);
	$select = 'SELECT p.*, country_name, b_showFullText, ref_data_uri, ref_data_body, ref_data_title, ref_source_title, language_name, native_name ';
	$select .= 'FROM publications p ';
	$select .= 'JOIN countries c USING (country_id) ';
	$select .= 'JOIN languages L USING (language_id) ';
	$select .= 'LEFT JOIN reference_linkage rl USING (pub_id ) ';
	$select .= 'LEFT JOIN reference_data rd USING (ref_data_id) ';
	$select .= 'LEFT JOIN reference_sources rs USING (ref_source_id) WHERE';
	$select .= $whereClause;
//  echo '<hr/>'. $select . '<hr/>';

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysql_error();
	} else {
		$result_cnt = mysqli_num_rows($queryResult);
		if ($result_cnt > 0) {
			if ($result_cnt < 500) {
				while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
				  /*
				  // AJE 2015-07-27 fill directly from database
					$str_pub_id              = trim($row['pub_id']);
					$str_ISSN                = trim($row['ISSN']);
					$str_OCLC                = trim($row['OCLC']);
					$str_marc001             = trim($row['marc001']);
					$str_pub_title 			     = trim($row['pub_title']);
					$str_pub_title_alt       = trim($row['pub_title_alt']);
					$str_pub_city            = trim($row['pub_city']);
					$str_country_id          = trim($row['country_id']);
					$str_pub_bgnDate         = trim($row['pub_bgnDate']);
					$str_pub_endDate         = trim($row['pub_endDate']);
					$str_date260C            = trim($row['date260C']);
					$str_date362             = trim($row['date362']);
					$str_freq_id_code        = trim($row['freq_id_code']);
					$str_frequency310        = trim($row['frequency310']);
					$str_former_freq_id_code = trim($row['former_freq_id_code']);
					$str_formerFrequency321  = trim($row['formerFrequency321']);
					$str_language_id         = trim($row['language_id']);
					$str_numberingNote515    = trim($row['numberingNote515']);
					$str_summary520          = trim($row['summary520']);
					$str_descriptionNote588  = trim($row['descriptionNote588']);
					$str_link856             = trim($row['link856']);
					$str_pub_note            = trim($row['pub_note']);
					$str_country_name        = trim($row['country_name']);
					$str_showFullText        = trim($row['b_showFullText']);
					$str_ref_data_uri        = trim($row['ref_data_uri']);
					$str_ref_data_body       = trim($row['ref_data_body']);
					$str_ref_data_title      = trim($row['ref_data_title']);
					$str_ref_source_title    = trim($row['ref_source_title']); */
					$titleInfo = array("pubId" => trim($row['pub_id']),
														 "issn" => trim($row['ISSN']),
														 "oclc" => trim($row['OCLC']),
														 "marc001" => trim($row['marc001']),
														 "pubTitle" => trim($row['pub_title']),
														 "pubTitleAlt" => trim($row['pub_title_alt']),
														 "pubCity" => trim($row['pub_city']),
														 "countryId" => trim($row['country_id']),
														 "pubBgnDate" => trim($row['pub_bgnDate']),
														 "pubEndDate" => trim($row['pub_endDate']),
														 "date260C" => trim($row['date260C']),
														 "date362" => trim($row['date362']),
														 "freqIdCode" => trim($row['freq_id_code']),
														 "freq310" => trim($row['frequency310']),
														 "formerFreqIdCode" => trim($row['former_freq_id_code']),
														 "formerFreq321" => trim($row['formerFrequency321']),
														 "language_id" => trim($row['language_id']),
														 "numberingNote515" => trim($row['numberingNote515']),
														 "summary520" => trim($row['summary520']),
														 "descriptionNote588" => trim($row['descriptionNote588']),
														 "bib_relationships" => trim($row['bib_relationships']),
														 "link856" => trim($row['link856']),
														 "pubNote" => trim($row['pub_note']),
														 "countryName" => trim($row['country_name']),
                             "language_name" => trim($row['language_name']),
                             "native_name" => trim($row['native_name']),
														 "showFullText" => trim($row['b_showFullText']),
														 "refDataURI" => trim($row['ref_data_uri']),
														 "refDataBody" => trim($row['ref_data_body']),
														 "refDataTitle" => trim($row['ref_data_title']),
														 "refSourceTitle" => trim($row['ref_source_title']));
					array_push($titleArray, $titleInfo);
				}

/*
//AJE preserved oroginal lines: 2013-06-21 14:25:38
				$encoded = json_encode($titleArray);
				die($encoded);
*/

	//CFJ 10/9/14 1:03PM
	//Sort title array by title field, then by city field.
	//Solution from http://us2.php.net/array_multisort
	foreach ($titleArray as $key => $row) {
    $title[$key]  = $row['pubTitle'];
    $city[$key] = $row['pubCity'];
	}
	array_multisort($title, SORT_ASC, $city, SORT_ASC, $titleArray);

//begin AJE test: 2013-06-21 14:25:52
	$encoded = json_encode($titleArray);
	setcookie("lastSQLquery", urlencode($select));
	die($encoded);
//end AJE test


			} else {
				echo "Too many titles to display";
			}
		} else {
			echo "No results returned";
		}
	}

	 mysqli_close($conn);
?>