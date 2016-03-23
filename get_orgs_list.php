<?php
/*
  This script by Constance Jurczyk, ca. 2012
    - gets information about the organizations holding valid issues of the given publication in ICON database.

  AJE 2013-11-11
    - now new setup:
      - orgInfo is the data for any single repository/organization
      - orgsArray is the final product, array of the individual reposInfo pieces, converted to JSON and returned
*/

	$pub_id = $_REQUEST['selectedPubId'];
	$orgInfo = array();
	$orgsArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");

/*

    // AJE 2015-02-03 saved original query
  $orgsQuery = 'SELECT DISTINCT o.org_id, o.org_name, i.issue_date ';
  $orgsQuery .= 'FROM issues i JOIN organizations o ON i.org_id = o.org_id ';
  $orgsQuery .= 'WHERE pub_id = "' . $pub_id . '" ';
  $orgsQuery .= 'AND i.issue_date <> "0000-00-00" ORDER BY org_name, issue_date';

  // 2015-02-03 AJE:  want a version that first gets the distinct org_ids
    then gets the min-max dates for each org in the loop for each org

  removing issue_date from the original query made it faster

  IN SOME CASES IS FASTER, BUT NEEDS RE-TESTING

*/

  // 2015-02-03 AJE: new query to avoid hitting issues table
	$orgsQuery  = "SELECT DISTINCT A2.org_id, o.org_name ";
	$orgsQuery .= "FROM A2issues_per_organization A2 ";
	$orgsQuery .= "JOIN organizations o ON A2.org_id = o.org_id ";
	$orgsQuery .= "WHERE A2.pub_id = '" . $pub_id . "' ";
	$orgsQuery .= "ORDER BY org_name";
	/* 2015-02-03 AJE: original query with issues table
  $orgsQuery = 'SELECT DISTINCT i.org_id AS org_id, o.org_name ';
  $orgsQuery .= 'FROM issues i JOIN organizations o ON i.org_id = o.org_id ';
  $orgsQuery .= 'WHERE pub_id = "' . $pub_id . '" ';
  $orgsQuery .= 'AND i.issue_date <> "0000-00-00" ORDER BY org_name';
  */

	$orgsResult = @mysqli_query($conn, $orgsQuery) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($orgsResult);
	if (!$orgsResult) {
		echo mysql_error();
	} else {
		while($orgRow = mysqli_fetch_array($orgsResult, MYSQL_ASSOC)) {
      // fill max and min dates here, all new AJE 2015-02-03
      // AJE 2015-02-04 added test: using new C3 table, faster lookups of MIN/MAX dates
      // if the test version for sn83030007 is better, eventually this all should become the new version
      /*
        2015-02-05 after filling C3:
        http://icon.crl.edu/calendar.php?pub_id=sn83030007
          get_orgs_list.php:
        http://192.168.1.142/ICONSANDBOX/calendar.php?pub_id=sn83030007
          SyntaxError: JSON.parse: unterminated string at line 1 column 33554433 of the JSON data
          http://192.168.1.142/ICONSANDBOX/javascripts/calendar_selection_functions.js
          Line 956
      */

/* 2015-02-10
  // this block preserved from intermediate step before C3 was filled
      if ($pub_id == 'sn83030007') {
        $dateQuery = 'SELECT MINissue_date, MAXissue_date ';
        $dateQuery .= 'FROM C3publications_per_org WHERE pub_id = "' . $pub_id . '" ';
        $dateQuery .= 'AND org_id = "' . $orgRow['org_id'] . '" ';
      } else {
        $dateQuery = 'SELECT MIN(issue_date) AS MINissue_date, MAX(issue_date) AS MAXissue_date ';
        $dateQuery .= 'FROM issues WHERE pub_id = "' . $pub_id . '" ';
        $dateQuery .= 'AND org_id = "' . $orgRow['org_id'] . '" AND issue_date <> "0000-00-00" ';
      }
*/

    // 2015-02-10 new version using C3publications_per_org for all pubs
      $dateQuery = 'SELECT MINissue_date, MAXissue_date ';
      $dateQuery .= 'FROM C3publications_per_org WHERE pub_id = "' . $pub_id . '" ';
      $dateQuery .= 'AND org_id = "' . $orgRow['org_id'] . '" ';

      $dateResult = @mysqli_query($conn, $dateQuery) or die( mysqli_error($conn) );
    	if (!$dateResult) {
	      echo mysql_error();
      }
			$dateRow = mysqli_fetch_array($dateResult, MYSQL_ASSOC);

      // AJE 2016-02-11 sometimes C3publications_per_org has no data for this org/pub
      //echo 'dateRow = ' . $dateRow; // 'Array'
      //var_dump($dateRow);
      if( is_null($dateRow) ){
        $dateRow = array(
          'MINissue_date' => '0000-00-00',
          'MAXissue_date' => '0000-00-00',
        );
      }
      if ( is_null($dateRow['MINissue_date']) ){
        $dateRow['MINissue_date'] = '0000-00-00';
      }
      if ( is_null($dateRow['MAXissue_date']) ){
        $dateRow['MAXissue_date'] = '0000-00-00';
      }


      // AJE 2015-02-03 : one array element contains the MIN date
			$orgInfo = array(
			  'org_id' => $orgRow['org_id'],            // for AJE Google Chart API script
			  'repository_name' => $orgRow['org_name'], // for AJE Google Chart API script
			  'org_name' => $orgRow['org_name'],        // AJE 2014-09-23 real version for future, coexisting here so as not to break things
			  'issue_date' => $dateRow['MINissue_date'] // CFJ 2015-01-29 changed field name from 'pubDate' to 'issue_date', as part of effort to eliminate discrepancy between server-side and client-side variable names
			  // AJE 2015-02-03 note new field filling that var
      );

      array_map("utf8_encode", $orgInfo);  // new 2015-02-03
      array_push($orgsArray, $orgInfo);

      // AJE 2015-02-03 : now a second piece of JSON with the MAX date
			$orgInfo = array(
			  'org_id' => $orgRow['org_id'],
			  'org_name' => $orgRow['org_name'],
			  'repository_name' => $orgRow['org_name'],
			  'org_name' => $orgRow['org_name'],
			  'issue_date' => $dateRow['MAXissue_date'] // AJE 2015-02-03
      );

      array_map("utf8_encode", $orgInfo);  // new 2015-02-03
      array_push($orgsArray, $orgInfo);


		} // end while
		$json = array("organizations" => $orgsArray);
		$encoded = json_encode($json);

    // AJE 2015-02-06 trying to resolve parse.JSON error when it gets to Javascript
    //      hide this section to get it to appear in browser for debuging
		$Content_Length = mb_strlen(serialize($encoded), '8bit');
		$Content_Length = $Content_Length + 1;
    //echo 'presumed Content_Length = ' . $Content_Length . '.';
		// 2015-07-22 : randomly not loading all the JSON ; removing next line fixes it
		//header('Content-Length: ' . $Content_Length . '; Content-Type: application/json; charset=utf-8');
    // resume original

		die($encoded);
	}
	mysqli_close($conn);
?>