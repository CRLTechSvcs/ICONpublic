<?php
	$selectedPubId = $_REQUEST['selectedPubId'];
	$innerArray = array();
	$issueArray = array();
	$namePattern = "/^New York State - [a-zA-Z0-9]{3}$/";
	$codePattern = "/ - [a-zA-Z0-9]{3}$/";
	$matchArray = array();
	include ("config.php");
	
	$select  = 'SELECT i.*, c.condition_name, f.format_name, a.archive_status_name, r.repos_name ';
	$select .= 'FROM issues i, conditions c, formats f, archive_status a, repositories r ';
	$select .= 'WHERE i.condition_id = c.condition_id AND i.format_id = f.format_id AND i.archive_status_id = a.archive_status_id ';
	$select .= 'AND i.repos_id = r.repos_id AND issue_date <> "0000-00-00"';
	$select .= 'AND pub_id = "' . $selectedPubId . '" ORDER BY issue_date';
	
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	$numrows = mysqli_num_rows($queryResult);
	if (!$queryResult) {
		echo mysql_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempIssueId = $row['issue_id'];
			$tempPubDate = $row['issue_date'];
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
			
			$tempPhysCondition = $row['condition_name'];
			$tempFormat = $row['format_name'];
			if ($tempFormat == 'Digital (pdf)') $tempFormat = 'Digital pdf';
			$tempArchiveStatus = $row['archive_status_name'];
			$tempProvenance = $row['provenance'];
			$tempUpdateDate = $row['update_date'];
			$tempNotes = $row['issue_note'];
			$innerArray = array("issueId" => $tempIssueId, "pubDate" => $tempPubDate, "repositoryId" => $tempRepositoryId, "repositoryName" => $tempRepositoryName, 
			                    "physCondition" => $tempPhysCondition, "format" => $tempFormat, "archiveStatus" => $tempArchiveStatus, "provenance" => $tempProvenance, "updateDate" => $tempUpdateDate, "notes" => $tempNotes);
			array_push($issueArray, $innerArray);
		}
		$json = array("allIssues" => $issueArray);
		$encoded = json_encode($json);
		die($encoded);
	}
	mysqli_close($conn);
?>