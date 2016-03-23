<?php

  /* get_CSV_pie_chart_d3.php
      2015-07-22

    - input: pub_id (see config.php)
    - output: database data that mimics the CSV format that the D3 javascript wants, like:

file_body
    org_id,org_total
    MEA,40
    MEASP,39
    MEUSP,39
    BYN,35
    NcGrE,35
    BYNSP,33

  */

  require_once('config.php');

  if ( isset($_REQUEST['pub_id']) ){
    $pub_id = $_REQUEST['pub_id'];
  } else { // fill default pub_id
    $pub_id = 'sn84023370';
  }

  $file_body = "org_id,org_total\n"; // we can put the whole file_body as shown in header comments right into the output here, and d3.csv() [NOT JSON] will produce correct chart
  //die($file_body);


/********************************************************************
  begin filling $holders: list of orgs

  DEVNOTE: the array $holders (a set of org_ids)
    must be in order of how many total issues of this publication the org holds
    - using GROUP BY and ORDER BY to make this happen

********************************************************************/
  $holders = array();
  $sql_holders = 'SELECT org_id, COUNT(*) AS org_issue_count FROM issues ';
    // DEVNOTE: in visualizations.publications, pub_id is an  INT
    // in icondata, it is text: need quotes here
  $sql_holders .= 'WHERE pub_id = "' . $pub_id . '" ';
  $sql_holders .= "AND issue_date <> '0000-00-00' ";
  $sql_holders .= 'GROUP BY org_id ';
  $sql_holders .= 'ORDER BY org_issue_count DESC, org_id ASC';
  //echo $sql_holders . '<br/>';
  $holders_result  = @mysqli_query($conn, $sql_holders) or die( mysqli_error($conn) );
  	if (!$holders_result) {
		echo mysql_error();
	} else {
		while($holder_row = mysqli_fetch_array($holders_result, MYSQL_ASSOC)) {
      $file_body .= $holder_row['org_id'] . ',' . $holder_row['org_issue_count'] . "\n";
	  }// end while
	}//end else

die($file_body);

mysqli_close($conn);
?>


<!--end get_org_info.php-->