<?php

/*
	calendarFunctions.php - called in calendarDBtest.php
*/

/***************************************************************************************/
function fillStringVars($datasource){ //put database or form data in string variables
	global $row; //this record
		//fields in the record
	global $str_record_id, $str_pub_id, $str_pub_date;
	global $str_repository, $str_phys_condition, $str_format, $str_notes;

	if ($datasource == "database"){
		$str_record_id 	= trim($row["issue_id"]);
		$str_pub_id 		= trim($row["pub_id"]);
		$str_pub_date 	= trim($row["pub_date"]);
		$str_repository	= trim($row["repository_id"]);
		$str_phys_condition = trim($row["phys_condition"]);
		$str_format		  = trim($row["format"]);
		$str_notes		  = trim($row["notes"]);
	} else { //for form data, or fileupload, or blank if form not submitted
		//see the original code in ./IMLS/includes/applicationConfiguration.php
		echo "<h4>fillStringVars hit the else...no output</h4>";
	}//end else not database
	//echo "<h4>fillStringVars(" . $datasource . ") is done</h4>";
}//end fillStringVars




/***************************************************************************************/
function setTRcolor($str_record_id){
	global $strTRcolor, $strTRcolorAlt;
	if (($str_record_id % 2) != 0) {
		$strTRcolor 		= "#adbd90"; //darker
		$strTRcolorAlt 	= "#e9e6d3";	//lighter
	} else {
			$strTRcolor 		= "#e9e6d3";
			$strTRcolorAlt 	= "#adbd90";
	} //end if
	return $strTRcolor;
	echo "<h3>setTRcolor #" . $str_record_id . ": col=" . $strTRcolor . ", alt=" . $strTRcolorAlt . "</h3>";
}//end setTRcolor



//end calendarFunctions.php
?>