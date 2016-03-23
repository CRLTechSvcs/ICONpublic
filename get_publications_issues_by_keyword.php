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

	$publications_sql = 'SELECT p.*, country_name, language_name, native_name ';
	$publications_sql .= 'FROM publications p JOIN countries c USING (country_id) JOIN languages L USING (language_id) ';
	$publications_sql .= 'WHERE ' . $whereClause;
  //echo '<hr/>'. $publications_sql . '<hr/>';

	$publications_query_result = @mysqli_query($conn, $publications_sql) or die( mysqli_error($conn) );
	if (!$publications_query_result) { echo mysql_error(); }
	else { // valid publications_query_result
		$num_publications = mysqli_num_rows($publications_query_result);
		if ($num_publications > 500) {
		  //echo "Too many titles to display";
  					$titleInfo = array( "pub_id" => '', "ISSN" => '', "OCLC" => '', "marc001" => '',
  						 "pub_title" => 'Too many titles to display',  "pub_title_alt" => '', "pub_city" => '', "country_id" => '', "pub_bgnDate" => '', "pub_endDate" => '', "date260C" => '', "date362" => '', "freq_id_code" => '', "frequency310" => '', "former_freq_id_code" => '', "formerFrequency321" => '', "language_id" => '', "numberingNote515" => '', "summary520" => '', "descriptionNote588" => '', "bib_relationships" => '', "link856" => '', "pubNote" => '', "country_name" => '', "language_name" => '', "native_name" => '',
               "first_issue_date" => '0000-00-00', "first_issue_org_count" => 0, "first_issue_org_id" => '', "first_issue_org_name" => '', "first_issue_format_name" => '',
               "last_issue_date" => '0000-00-00', "last_issue_org_count" => 0, "last_issue_org_id" => '', "last_issue_org_name" => '', "last_issue_format_name" => '',
  					);
  					array_push($titleArray, $titleInfo);
		}
		elseif($num_publications <= 0) {
		  //echo "No results returned";
  					$titleInfo = array( "pub_id" => '', "ISSN" => '', "OCLC" => '', "marc001" => '',
  						 "pub_title" => 'No results returned',  "pub_title_alt" => '', "pub_city" => '', "country_id" => '', "pub_bgnDate" => '', "pub_endDate" => '', "date260C" => '', "date362" => '', "freq_id_code" => '', "frequency310" => '', "former_freq_id_code" => '', "formerFrequency321" => '', "language_id" => '', "numberingNote515" => '', "summary520" => '', "descriptionNote588" => '', "bib_relationships" => '', "link856" => '', "pubNote" => '', "country_name" => '', "language_name" => '', "native_name" => '',
               "first_issue_date" => '0000-00-00', "first_issue_org_count" => 0, "first_issue_org_id" => '', "first_issue_org_name" => '', "first_issue_format_name" => '',
               "last_issue_date" => '0000-00-00', "last_issue_org_count" => 0, "last_issue_org_id" => '', "last_issue_org_name" => '', "last_issue_format_name" => '',
  					);
  					array_push($titleArray, $titleInfo);
		} else { //num_publications between 1 and 500
				while($publications_row = mysqli_fetch_array($publications_query_result, MYSQL_ASSOC)) {
        $this_pub_id = trim($publications_row['pub_id']);

				    // for each title, get issue information, one each for MIN and MAX dates
  		  $first_issue_sql = 'SELECT MIN(i.issue_date) AS first_issue_date, COUNT(*) AS first_issue_org_count, i.org_id AS first_issue_org_id, ';
  		  $first_issue_sql .= 'G.org_name AS first_issue_org_name, f.format_name AS first_issue_format_name ';
  		  $first_issue_sql .= 'FROM issues i JOIN organizations G ON G.org_id = i.org_id JOIN formats f ON f.format_id = i.format_id ';
  		  $first_issue_sql .= 'WHERE i.pub_id = "' . $this_pub_id . '" ';
  		  $first_issue_sql .= 'AND i.issue_date = ( SELECT MIN(issue_date) FROM issues WHERE pub_id = "' . $this_pub_id . '" ) ';
        //echo '<hr/>'. $first_issue_sql . '<hr/>';

        $first_issue_query_result = @mysqli_query($conn, $first_issue_sql) or die( mysqli_error($conn) );

        if (!$first_issue_query_result) { echo mysql_error(); }
        else { // valid first_issue_query_result
          $num_first_issue_rows = mysqli_num_rows($first_issue_query_result);
          //echo '<hr/>num_first_issue_rows'. $num_first_issue_rows . '<hr/>';
          if ($num_first_issue_rows > 0) {
            while($first_issue_row = mysqli_fetch_array($first_issue_query_result, MYSQL_ASSOC)) {
  /*
  echo '<hr/>in while: first_issue_row: = '. var_dump($first_issue_row) . '<br/>';
  echo 'and first_issue_row[first_issue_date] = '. var_dump($first_issue_row['first_issue_date']) . '<br/>';
  */
              $first_issue_date = trim($first_issue_row['first_issue_date']);

              if( $first_issue_row === NULL || $first_issue_date == '0000-00-00' ){
                $first_issue_date       = '[no ICON first issue]'; $first_issue_format_name = '&nbsp;'; $first_issue_org_id   = '&nbsp;'; $first_issue_org_name   = '&nbsp;'; $first_issue_org_count  = 0;
                // and if we have no first_issue_date, there will be no valid last_issue_date, so:
                $last_issue_date  = '[no ICON last issue]'; $last_issue_format_name = '&nbsp;'; $last_issue_org_id   = '&nbsp;'; $last_issue_org_name   = '&nbsp;'; $last_issue_org_count  = 0;
              } else { // there was a valid first issue
                //$first_issue_date set before the IF
                $first_issue_org_id   = trim($first_issue_row['first_issue_org_id']);
                $first_issue_org_name   = trim($first_issue_row['first_issue_org_name']);
                $first_issue_format_name = trim($first_issue_row['first_issue_format_name']);
                $first_issue_org_count  = trim($first_issue_row['first_issue_org_count']);

                // now let's get the MAX versions for the last_issue_date, etc fields
          		  $last_issue_sql = 'SELECT MAX(i.issue_date) AS last_issue_date, COUNT(*) AS last_issue_org_count,  i.org_id AS last_issue_org_id, ';
          		  $last_issue_sql .= 'G.org_name AS last_issue_org_name, f.format_name AS last_issue_format_name ';
          		  $last_issue_sql .= 'FROM issues i JOIN organizations G ON G.org_id = i.org_id JOIN formats f ON f.format_id = i.format_id ';
          		  $last_issue_sql .= 'WHERE i.pub_id = "' . $this_pub_id . '" ';
          		  $last_issue_sql .= 'AND i.issue_date = ( SELECT MAX(issue_date) FROM issues WHERE pub_id = "' . $this_pub_id . '" ) ';
                //echo '<hr/>last_issue_sql: '. $last_issue_sql . '<hr/>';
                $last_issue_query_result = @mysqli_query($conn, $last_issue_sql) or die( mysqli_error($conn) );

                if (!$last_issue_query_result) { echo mysql_error(); }
                else {
                  $num_last_issue_rows = mysqli_num_rows($last_issue_query_result);
                  //echo '<hr/>num_last_issue_rows'. $num_last_issue_rows . '<hr/>';
                  if ($num_last_issue_rows > 0) {
                    while($last_issue_row = mysqli_fetch_array($last_issue_query_result, MYSQL_ASSOC)) {
                      $last_issue_date = trim($last_issue_row['last_issue_date']);
                      if( $last_issue_row === NULL || $last_issue_date == '0000-00-00' ){
                        $last_issue_date  = '[no ICON last issue]'; $last_issue_format_name = '&nbsp;'; $last_issue_org_id   = '&nbsp;'; $last_issue_org_name   = '&nbsp;'; $last_issue_org_count  = 0;
                      } else {
                        //$last_issue_date set before the IF
                        $last_issue_org_id   = trim($last_issue_row['last_issue_org_id']);
                        $last_issue_org_name   = trim($last_issue_row['last_issue_org_name']);
                        $last_issue_format_name = trim($last_issue_row['last_issue_format_name']);
                        $last_issue_org_count  = trim($last_issue_row['last_issue_org_count']);
                      } // end if last_issue_row IS NOT NULL
                    } // end while last_issue_query_result
                  } //end if num_last_issue_rows

//echo 'for ' . $this_pub_id . ', first_issue_date, '. $first_issue_date . ' ; first_issue_org_count, '. $first_issue_org_count . ' ; first_issue_org_id, '. $first_issue_org_id . '' ; first_issue_org_name, '. $first_issue_org_name . ' ; format_name, '. $first_issue_format_name . '<hr/>';
  		          }// end else: valid last_issue_query_result
              } // end else: there was a valid first issue
            }		// end while: first_issue_row
  				} // end if num_first_issue_rows
  			} // end else: valid first_issue_query_result


  					$titleInfo = array(
  					  "pub_id" => $this_pub_id,
  						 "ISSN" => trim($publications_row['ISSN']),
  						 "OCLC" => trim($publications_row['OCLC']),
  						 "marc001" => trim($publications_row['marc001']),
  						 "pub_title" => trim($publications_row['pub_title']),
  						 "pub_title_alt" => trim($publications_row['pub_title_alt']),
  						 "pub_city" => trim($publications_row['pub_city']),
  						 "country_id" => trim($publications_row['country_id']),
  						 "pub_bgnDate" => trim($publications_row['pub_bgnDate']),
  						 "pub_endDate" => trim($publications_row['pub_endDate']),
  						 "date260C" => trim($publications_row['date260C']),
  						 "date362" => trim($publications_row['date362']),
  						 "freq_id_code" => trim($publications_row['freq_id_code']),
  						 "frequency310" => trim($publications_row['frequency310']),
  						 "former_freq_id_code" => trim($publications_row['former_freq_id_code']),
  						 "formerFrequency321" => trim($publications_row['formerFrequency321']),
  						 "language_id" => trim($publications_row['language_id']),
  						 "numberingNote515" => trim($publications_row['numberingNote515']),
  						 "summary520" => trim($publications_row['summary520']),
  						 "descriptionNote588" => trim($publications_row['descriptionNote588']),
  						 "bib_relationships" => trim($publications_row['bib_relationships']),
  						 "link856" => trim($publications_row['link856']),
  						 "pubNote" => trim($publications_row['pub_note']),
  						 "country_name" => trim($publications_row['country_name']),
               "language_name" => trim($publications_row['language_name']),
               "native_name" => trim($publications_row['native_name']),
  // issues details
               "first_issue_date" => $first_issue_date,
               "first_issue_org_count" => $first_issue_org_count,
               "first_issue_org_id" => $first_issue_org_id,
               "first_issue_org_name" => $first_issue_org_name,
               "first_issue_format_name" => $first_issue_format_name,

               "last_issue_date" => $last_issue_date,
               "last_issue_org_count" => $last_issue_org_count,
               "last_issue_org_id" => $last_issue_org_id,
               "last_issue_org_name" => $last_issue_org_name,
               "last_issue_format_name" => $last_issue_format_name
  					);

  					array_push($titleArray, $titleInfo);
        } // end while publications_row

        	//CFJ 10/9/14 1:03PM
        	//Sort title array by title field, then by city field.
        	//Solution from http://us2.php.net/array_multisort
        	foreach ($titleArray as $key => $publications_row) {
            $title[$key]  = $publications_row['pub_title'];
            $city[$key] = $publications_row['pub_city'];
        	}
        	array_multisort($title, SORT_ASC, $city, SORT_ASC, $titleArray);
    } // end else: num_publications between 1 and 500
  } //  end else: valid publications_query_result

  //begin AJE test: 2013-06-21 14:25:52
  	$encoded = json_encode($titleArray);
  	setcookie("lastSQLquery", urlencode($publications_sql));
  	die($encoded);
  //end AJE test

	 mysqli_close($conn);
?>