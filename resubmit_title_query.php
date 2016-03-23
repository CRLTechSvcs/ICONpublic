<?php

	include ("config.php");

	//Initialize publications table fields
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
	$str_numberingNote515    = '';
	$str_summary520          = '';
	$str_descriptionNote588  = '';
	$str_relationships			 = '';
	$str_link856             = '';
	$str_pub_note            = '';
	$str_country_name        = '';
	$str_showFullText        = '';
	$str_ref_data_uri        = '';
	$str_ref_data_body       = '';
	$str_ref_data_title      = '';
	$str_ref_source_title    = '';

	//Initialize searchterm parameters
	$title_parameter = '';
	$lccn_parameter = '';
	$oclc_parameter = '';
	$issn_parameter = '';
	$city_parameter = '';
	$keyword_parameter = '';
	$state_country_parameter = '';
	$state_country_name_parameter = '';

	//Initialize other variables
	$foundInField = 'none';
	$titleArray = array();
	$pubIdArray = array();
	$whereArray = array();
	$json = array();

  if(isset($_REQUEST['lastSQLquery'])) {
  	$select = urldecode($_REQUEST['lastSQLquery']);
  }

	//echo urldecode($select);
	//echo $select;



	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysql_error();
	} else {
		$result_cnt = mysqli_num_rows($queryResult);
		if ($result_cnt > 0) {
			if ($result_cnt < 500) {
				while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
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
					$str_numberingNote515    = trim($row['numberingNote515']);
					$str_summary520          = trim($row['summary520']);
					$str_descriptionNote588  = trim($row['descriptionNote588']);
					$str_relationships			 = trim($row["bib_relationships"]);
					$str_link856             = trim($row['link856']);
					$str_pub_note            = trim($row['pub_note']);
					$str_country_name        = trim($row['country_name']);
					$str_showFullText        = trim($row['b_showFullText']);
					$str_ref_data_uri        = trim($row['ref_data_uri']);
					$str_ref_data_body       = trim($row['ref_data_body']);
					$str_ref_data_title      = trim($row['ref_data_title']);
					$str_ref_source_title    = trim($row['ref_source_title']);
					$titleInfo = array("pubId" => $str_pub_id,
														 "issn" => $str_ISSN,
														 "oclc" => $str_OCLC,
														 "marc001" => $str_marc001,
														 "pubTitle" => $str_pub_title,
														 "pubTitleAlt" => $str_pub_title_alt,
														 "pubCity" => $str_pub_city,
														 "countryId" => $str_country_id,
														 "pubBgnDate" => $str_pub_bgnDate,
														 "pubEndDate" => $str_pub_endDate,
														 "date260C" => $str_date260C,
														 "date362" => $str_date362,
														 "freqIdCode" => $str_freq_id_code,
														 "freq310" => $str_frequency310,
														 "formerFreqIdCode" => $str_former_freq_id_code,
														 "formerFreq321" => $str_formerFrequency321,
														 "numberingNote515" => $str_numberingNote515,
														 "summary520" => $str_summary520,
														 "descriptionNote588" => $str_descriptionNote588,
														 "bib_relationships" => $str_relationships,
														 "link856" => $str_link856,
														 "pubNote" => $str_pub_note,
														 "countryName" => $str_country_name,
														 "showFullText" => $str_showFullText,
														 "refDataURI" => $str_ref_data_uri,
														 "refDataBody" => $str_ref_data_body,
														 "refDataTitle" => $str_ref_data_title,
														 "refSourceTitle" => $str_ref_source_title);
					array_push($titleArray, $titleInfo);
				}

/*
//AJE preserved oroginal lines: 2013-06-21 14:25:38
				$encoded = json_encode($titleArray);
				die($encoded);
*/
//begin AJE test: 2013-06-21 14:25:52
				$encoded = json_encode($titleArray);
				setcookie("lastSQLquery", $select);
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