<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$repositoryArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");
		
	$select  = 'SELECT repositories.repos_id, repositories.repos_name FROM repositories ';
	$select .= 'WHERE repositories.repos_id IN ';
	$select .= '(SELECT issues.repos_id FROM issues WHERE issues.pub_id = "' . $selectedPubId . '") ';
	$select .= 'ORDER BY repositories.repos_name';
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempRepositoryId = $row['repos_id'];
			$tempRepositoryName = $row['repos_name'];
			
			/*
			//9/21/12 - Andy uppercased the code portion of repository names directly in the database,
			//so statements in this section are no longer needed.  CFJ.
			//Upper-case three letter codes in repository names like 'New York State - Lii'
			if (preg_match($namePattern, $tempRepositoryName, $matchArray) == 1) {
			 preg_match($codePattern, $tempRepositoryName, $matchArray);			 
			 $tempCodeOriginal = substr($matchArray[0],3);
			 $tempCodeUpper = strtoupper ($tempCodeOriginal);
			 $tempRepositoryName = str_replace($tempCodeOriginal, $tempCodeUpper, $tempRepositoryName);				 
			}
			*/
			
			$dateSelect = 'SELECT MIN(YEAR(issue_date)) as minyear, MAX(YEAR(issue_date)) as maxyear FROM issues WHERE pub_id = "' . $selectedPubId . '" AND issue_date != "0000-00-00" AND repos_id = "' . $tempRepositoryId . '"';
			$dateQueryResult = @mysqli_query($conn, $dateSelect) or die( mysqli_error($conn) );
			if (!$dateQueryResult) {
				echo mysql_error();
			} else {
				$dateRow = mysqli_fetch_array($dateQueryResult, MYSQL_ASSOC);
				$minYear = $dateRow['minyear'];
				$maxYear = $dateRow['maxyear'];
			}
			if ($maxYear <> null) {
				$innerArray = array('repositoryId' => $tempRepositoryId, 'repositoryName' => $tempRepositoryName, 'minYear' => $minYear, 'maxYear' => $maxYear);
				$outerArray = array('repositoryInfo' => $innerArray);
				array_push($repositoryArray, $outerArray);
			}
		}
		$json = array("repositories" => $repositoryArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>