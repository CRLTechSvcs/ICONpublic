<?php

  /* 2014-09-23 called from: calendar_selection_functions.js > function displayFilterLinks() */
  /* 2015-02-03 AJE revised with
      1) new PHP variable names:
          ACTUALLY NEVER MIND FOR NOW but eliminated various $tmp* vars
      2) querying organizations table
      3) new headers and encoding, trying to tackle random JSON.parse errors */

	$availableOrgsArray = $_REQUEST['availableOrganizations'];
	$organizations = array();
	include ("config.php");


	for ($i = 0; $i < count($availableOrgsArray); $i++) {
		$selectedOrgId = $availableOrgsArray[$i];
		$select = 'SELECT * FROM organizations o JOIN organization_types ot USING (org_type_id) WHERE org_id = "' . $selectedOrgId . '"';
		$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
		if (!$queryResult) {
			echo mysqli_error();
		} else {
				$row = mysqli_fetch_array($queryResult, MYSQL_ASSOC);
				$orgInfo = array("repositoryId" => $row['org_id'],
				  "marcOrgCode" => $row['org_marcOrgCode'],
				  "OCLCId" => $row['org_oclc_identifier'],
				  "org_type_id" => $row['org_type_id'],
				  "org_name" => $row['org_name'],
  				//The org_display_name field may someday hold a shorter version of repository name
  				//For now, don't capture or display
  				//"repositoryDisplayName" => $row['org_display_name'],
				  "street1" => $row['org_street1'],
				  "street2" => $row['org_street2'],
				  "city" => $row['org_city'],
				  //"stateProvinceText" => $row['stateProvince_TEXT'],
				  //"stateProvinceId" => $row['stateProvince_id'],
				  //"stateProvinceCode" => $row['stateProvince_Code'],
				  //"countryText" => $row['country_TEXT'],
				  "countryId" => $row['country_id'],
				  "postalCode" => $row['org_postalCode'],
				  "latitude" => $row['org_latitude'],
				  "longitude" => $row['org_longitude'],
				  "homeURI" => $row['org_home_uri'],
				  "opacURI" => $row['org_opac_uri'],
				  "reposUpdateDate" => $row['org_update_date'],
				  "repositoryNote" => $row['org_note'],
				  "repositoryTypeName" => $row['org_type_name']
				  );
		} // end else

		array_map("utf8_encode", $orgInfo);  // new 2015-02-03
		array_push($organizations, $orgInfo);

	} //end for

	$encoded = json_encode($organizations);


  // AJE 2015-02-03 trying to resolve parse.JSON error when it gets to Javascript
	$Content_Length = mb_strlen(serialize($encoded), '8bit');
	$Content_Length = $Content_Length + 1;
  //echo 'presumed Content_Length = ' . $Content_Length . '.';
  /*
    AJE : 2015-10-01 :
    next line may have been causing issue_trigger not to get the correct click action:
      - result: filter down to orgs for a specific issue date, click the org, entire page reloads
  */
	//header('Content-Length: ' . $Content_Length . '; Content-Type: application/json; charset=utf-8');

  // resume original


	die($encoded);
	mysqli_close($conn);

?>