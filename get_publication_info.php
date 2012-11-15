<?php

/**********************************************************
DATABASE icondata;
mysql> DESCRIBE publications;
+--------------------+-------------+------+-----+---------+-------+
| Field              | Type        | Null | Key | Default | Extra |
+--------------------+-------------+------+-----+---------+-------+
| pub_id             | varchar(15) | NO   | PRI |         |       |
| marc001            | tinytext    | YES  |     | NULL    |       |
| pub_title          | text        | YES  |     | NULL    |       |
| pub_title_alt      | text        | YES  |     | NULL    |       |
| pub_city           | tinytext    | YES  |     | NULL    |       |
| state_province_id  | tinytext    | YES  |     | NULL    |       |
| country_id         | varchar (3) | YES  |     | NULL    |       |
| freq_id_code       | tinytext    | YES  |     | NULL    |       |
| pub_bgnDate        | tinytext    | YES  |     | NULL    |       |
| pub_endDate        | tinytext    | YES  |     | NULL    |       |
| date260C           | tinytext    | YES  |     | NULL    |       |
| frequency310       | tinytext    | YES  |     | NULL    |       |
| formerFrequency321 | mediumtext  | YES  |     | NULL    |       |
| date362            | mediumtext  | YES  |     | NULL    |       |
| numberingNote515   | mediumtext  | YES  |     | NULL    |       |
| summary520         | mediumtext  | YES  |     | NULL    |       |
| descriptionNote588 | tinytext    | YES  |     | NULL    |       |
+--------------------+-------------+------+-----+---------+-------+
17 rows in set (0.12 sec)

//sample of the first few table lines
pub_id|marc001|pub_title|pub_title_alt|pub_city|pub_state|country_code|freq_id_code|pub_bgnDate|pub_endDate|date260C|frequency310|formerFrequency321|date362|numberingNote515|summary520|descriptionNote588
00062183|\\\00062183|Polak amerykan´ski = American Pole||Buffalo|37|nyu|d|190?|19??||Daily|||Contains numbering irregularities.||
00211074|ocm43209784|The champion newspaper||Decatur|13|gau|w|19??|current||Weekly|||||
00211320|ocm33811902|Chungang ilbo = The Korea central daily||San Francisco|6|cau|d|19??|current||Daily (except Monday & certain holidays)|||||
00212294|\\\00212294|The voice of agriculture||St. Paul|28|mnu|m|2000|current|2000-|Monthly (except bimonthly in Apr./May and Nov./Dec.)||Vol. 20, no. 1 (Jan. 2000)-|||
*/



	$thisPub_id = str_replace("%20", "", $_REQUEST['pub_id']);//strip spaces out of the pub_id passed in from bib rec


	include ("config.php");


	//$select  = 'SELECT *, country_name FROM publications p ';
	//$select .= 'JOIN countries c WHERE p.country_id = c.country_id AND pub_id = "' . $thisPub_id . '" ';
	
	$select = 'SELECT p.*, country_name, b_showFullText, ref_data_uri, ref_data_body, ref_data_title, ref_source_title FROM publications p ';
	$select .= 'JOIN countries c USING (country_id) ';
	$select .= 'LEFT JOIN reference_linkage rl USING (pub_id ) ';
	$select .= 'LEFT JOIN reference_data rd USING (ref_data_id) ';
	$select .= 'LEFT JOIN reference_sources rs USING (ref_source_id) ';
	$select .= 'WHERE pub_id = "' . $thisPub_id . '"';

	//initialize fields from table: publications
	$str_pub_id 						= "";
	$str_marc001						= "";
	$str_pub_title					    = "";
	$str_pub_title_alt			        = "";
	$str_pub_city						= "";
	$str_pub_state					    = "";
	$str_country_code				    = "";
	$str_country_name                   = "";
	$str_country_id				        = "";
	$str_pub_freq_id_code		        = "";
	$str_pub_bgnDate 				    = "";
	$str_pub_endDate 				    = "";
	$str_date260C 					    = "";
	$str_frequency310 			        = "";
	$str_formerFrequency321             = "";
	$str_date362 						= "";
	$str_numberingNote515 	            = "";
	$str_summary520 				    = "";
	$str_descriptionNote588	            = "";
	$str_ref_data_body                  = "";
	$str_ref_data_title                 = "";
	$str_ref_data_uri                   = "";
	$str_ref_source_title               = "";
	$b_show_full_text                 = "";

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	//echo "<h3>numrows=" . $numrows . " for pub_id " . $thisPub_id .  "</h3>";
	if (!$queryResult) {
		echo mysql_error();
	} else { //this while should actually last just one iteration: only 1 pub per id!
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			//echo "<h3>entered while</h3>";
			$str_pub_id 						= trim($row["pub_id"]);
			$str_marc001						= trim($row["marc001"]);
			$str_pub_title 					= trim($row["pub_title"]);
			$str_pub_city 					= trim($row["pub_city"]);
			//4/23/12 In the future, stateProvince_id field may be populated with state/province info for countries other than US and Canada
			//When that happens, uncomment the following line and pull state or province name from stateProvinces table via stateProvince_id
			//$str_stateProvinceId 				= trim($row["stateProvince_id"]);
			$str_country_id 				= trim($row["country_id"]);
			$str_country_name 				= trim($row["country_name"]);
			$str_pub_freq_id_code 	= trim($row["freq_id_code"]);
			//pub_bgnDate and pub_bgnDate are sort of junk fields that did not necessarily come from the bib data
			$str_pub_bgnDate 				= trim($row["pub_bgnDate"]);
			$str_pub_endDate 				= trim($row["pub_endDate"]);
			$str_date260C 					= trim($row["date260C"]);
			$str_frequency310 			= trim($row["frequency310"]);
			$str_formerFrequency321 = trim($row["formerFrequency321"]);
			$str_date362 						= trim($row["date362"]);
			$str_numberingNote515 	= trim($row["numberingNote515"]);
			$str_summary520 				= trim($row["summary520"]);
			$str_descriptionNote588 = trim($row["descriptionNote588"]);
			$str_ref_data_body      = trim($row["ref_data_body"]);
			$str_ref_data_title     = trim($row["ref_data_title"]);
			$str_ref_data_uri       = trim($row["ref_data_uri"]);
			$str_ref_source_title   = trim($row["ref_source_title"]);
			$b_show_full_text       = trim($row["b_showFullText"]);
		} //end fields from table: publications
	}
	 $json = array("pubId" => $str_pub_id, "marc001" => $str_marc001, "pubTitle" => $str_pub_title, "pubTitleAlt" => $str_pub_title_alt, 
		"pubCity" => $str_pub_city, "countryId" => $str_country_id, "countryName" => $str_country_name, "pubFreqIdCode" => $str_pub_freq_id_code, 
		"pubBgnDate" =>$str_pub_bgnDate, "pubEndDate" => $str_pub_endDate, "date260C" => $str_date260C, "frequency310" => $str_frequency310, 
		"formerFrequency321" => $str_formerFrequency321, "date362" => $str_date362, "numberingNote515" => $str_numberingNote515, 
		"summary520" => $str_summary520, "descriptionNote588" => $str_descriptionNote588, "refDataBody" => $str_ref_data_body, "refDataTitle" => $str_ref_data_title, 
		"refDataURI" => $str_ref_data_uri, "refSourceTitle" => $str_ref_source_title, "showFullText" => $b_show_full_text);
		
	 $encoded = json_encode($json);
	 die($encoded);
	 mysqli_close($conn);
?>