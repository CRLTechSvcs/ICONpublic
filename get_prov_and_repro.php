<?php
	$selectedIssueId = $_REQUEST['selectedIssueId'];
	$innerArray = array();
	$issueArray = array();
	include ("config.php");

	// 2014-09-30 AJE using ORGANIZATIONS table instead of reproducers (which has been dropped) ; see old zip files for the original SQL

	$select  = 'SELECT i.*, p.*, r1.*, o.*, c.* ';
	$select  .= 'FROM issues i, provenances p, reproductions r1, organizations o, countries c ';
	$select  .= 'WHERE i.issue_id = "' . $selectedIssueId . '" ';
	$select  .= 'AND p.provenance_id = i.provenance_id ';
	$select  .= 'AND p.reproduction_id = r1.reproduction_id ';
	$select  .= 'AND o.org_id = r1.reproducer_org_id ';
	$select  .= 'AND o.country_id = c.country_id';

	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$issue_id = $row['issue_id'];
			$provenance_id = $row['provenance_id'];
			$pub_id = $row['pub_id'];
			$provenance_note = $row['provenance_note'];
			$reproduction_description = $row['reproduction_description'];
			$reproduction_date_produced = $row['reproduction_date_produced'];
			$tempReproductionSeries = $row['reproduction_series'];
			$reproduction_datesVols = $row['reproduction_datesVols'];
			$reproduction_note = $row['reproduction_note'];
			$reproducer_name = $row['org_name'];
			$reproducer_city = $row['org_city'];
			$country_name = $row['country_name'];
			$innerArray = array(
			  "issueId" => $issue_id,
			  "provenance" => $provenance_id,
			  "pubId" => $pub_id,
			  "provNote" => $provenance_note,
			  "reproductionDesc" => $reproduction_description,
			  "reproductionDate" => $reproduction_date_produced,
			  "reproductionSeries" => $tempReproductionSeries,
			  "reproductionDatesVols" => $reproduction_datesVols,
			  "reproductionNote" => $reproduction_note,
			  "reproducerName" => $reproducer_name,
			  "reproducerCity" => $reproducer_city,
			  "reproducerCountry" => $country_name
      );
			array_push($issueArray, $innerArray);
		}
		$json = array("issues" => $issueArray);
		$encoded = json_encode($json);
		die($encoded);
	}

	// AJE 2014-09-30 : a giant chunk of code was commented out here, looks like just example from other get*.php : see previous versions in various zip files

	mysqli_close($conn);
?>