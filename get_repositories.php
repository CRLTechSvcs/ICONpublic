<?php
	$selectedRepositoryId = $_REQUEST['selectedRepositoryId'];
	include ("config.php");
	$select = 'SELECT *, repos_type_name from repositories r ';
	$select .= 'JOIN repository_types rt ';
	$select .= 'WHERE r.repos_type_id = rt.repos_type_id ';
	$select .= 'AND r.repos_id = "' . $selectedRepositoryId . '"';
	
	$queryResult = @mysqli_query($conn, $select) or die( mysqli_error($conn) );
	if (!$queryResult) {
		echo mysqli_error();
	} else {
		while($row = mysqli_fetch_array($queryResult, MYSQL_ASSOC)) {
			$tempRepositoryId = $row['repos_id'];
			$tempMarcOrgCode = $row['repos_marcOrgCode'];
			$tempOCLCId = $row['repos_oclc_identifier'];
			$tempRepositoryTypeId = $row['repos_type_id'];
			$tempRepositoryName = $row['repos_name'];
			$tempRepositoryDisplayName = $row['repos_display_name'];
			$tempStreet1 = $row['repos_street1'];
			$tempStreet2 = $row['repos_street2'];
			$tempCity = $row['repos_city'];
			$tempStateProvinceText = $row['stateProvince_TEXT'];
			$tempStateProvinceId = $row['stateProvince_id'];
			$tempCountryText = $row['country_TEXT'];
			$tempCountryId = $row['country_id'];
			$tempPostalCode = $row['repos_postalCode'];
			$tempLatitude = $row['repos_latitude'];
			$tempLongitude = $row['repos_longitude'];
			$tempHomeURL = $row['repos_homeURL'];
			$tempOpacURL = $row['repos_opacURL'];
			$tempLastUpdated = $row['lastUpdated'];
			$tempRepositoryNote = $row['repos_note'];
			$repositoryTypeName = $row['repos_type_name'];
		}
	}	
	$json = array("repositoryId" => $tempRepositoryId,
				  "marcOrgCode" => $tempMarcOrgCode,
				  "OCLCId" => $tempOCLCId,
				  "repositoryTypeId" => $tempRepositoryTypeId,
				  "repositoryDisplayName" => $tempRepositoryDisplayName,
				  "street1" => $tempStreet1,
				  "street2" => $tempStreet2,
				  "city" => $tempCity,
				  "stateProvinceText" => $tempStateProvinceText,
				  "stateProvinceId" => $tempStateProvinceId,
				  "countryText" => $tempCountryText,
				  "countryId" => $tempCountryId,
				  "postalCode" => $tempPostalCode,
				  "latitude" => $tempLatitude,
				  "longitude" => $tempLongitude,
				  "homeURL" => $tempHomeURL,
				  "opacURL" => $tempOpacURL,
				  "lastUpdated" => $tempLastUpdated,
				  "repositoryNote" => $tempRepositoryNote,
				  "repositoryTypeName" => $repositoryTypeName);
	$encoded = json_encode($json);
	die($encoded);
	mysqli_close($conn);
?>