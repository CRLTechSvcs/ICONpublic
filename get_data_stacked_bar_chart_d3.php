<?php

  /* get_CSV_stacked_bar_chart_d3.php

    - input: pub_id (see config.php)
    - output: database data that mimics the CSV format that the D3 javascript wants, like:

file_body
        issue_date,MEA,MEASP,MEUSP,BYN,NcGrE,BYNSP,year_total
        1974,1,1,1,1,0,1,5
        1975,1,1,1,1,1,1,6
        1976,1,1,1,1,1,1,6
        1977,1,1,1,1,0,1,5
        1978,1,1,1,1,0,1,5
        1979,1,1,1,1,1,1,6
        1980,1,1,1,1,1,1,6

  */

  require_once('config.php');

  if ( isset($_REQUEST['pub_id']) ){
    $pub_id = $_REQUEST['pub_id'];
  } else { // fill default pub_id
    $pub_id = 'sn84023370';
  }

  //var_dump($pub_id);

  $header_line = "Volume";
  $file_body = ""; // we can put the whole file_body as shown in header comments right into the output here, and d3.csv() [NOT JSON] will produce correct chart

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
  //$sql_holders .= 'WHERE pub_id = "sn84023370" ';
  $sql_holders .= "AND issue_date <> '0000-00-00' ";
  $sql_holders .= 'GROUP BY org_id ';
  $sql_holders .= 'ORDER BY org_issue_count DESC, org_id ASC';
  //echo '<br/>' . $sql_holders . '<br/>';
  $holders_result  = @mysqli_query($conn, $sql_holders) or die( mysqli_error($conn) );
  	if (!$holders_result) {
		echo mysql_error();
	} else {
		while($holder_row = mysqli_fetch_array($holders_result, MYSQL_ASSOC)) {
      $header_line .= ',' . $holder_row['org_id'];
      //$header_line .= ',' . $holder_row['org_issue_count']; // just testing
      $holders[] = $holder_row['org_id'];
	  }// end while
	}//end else
$header_line .= ",year_total\n";   //echo "header_line = " . $header_line . "<br/>";
$file_body .= $header_line;    //echo "file_body = " . $file_body . "<hr/>";

/********************************************************************
  end filling list of orgs
  begin filling $issue_dates: list of issue_dates

  this is for a chart, don't want every issue: use every year, so LEFT()

********************************************************************/
  $issue_dates = array();
  $sql_issue_dates = 'SELECT DISTINCT CAST(LEFT(issue_date,4) AS CHAR) AS issue_date FROM issues ';
  $sql_issue_dates .= 'WHERE pub_id = "' . $pub_id . '" ';
  $sql_issue_dates .= "AND issue_date <>  '0000-00-00' ";
  $sql_issue_dates .= 'ORDER BY issue_date';
  //echo '<br/>' . $sql_issue_dates . '<br/>';
  $issue_dates_result  = @mysqli_query($conn, $sql_issue_dates) or die( mysqli_error($conn) );
  	if (!$issue_dates_result) {
		echo mysql_error();
	} else {
		while($issue_date_row = mysqli_fetch_array($issue_dates_result, MYSQL_ASSOC)) {
      $issue_dates[] = $issue_date_row['issue_date'];
	  }// end while
	}//end else
//echo "there are " . count($holders) . " holders ; there are " . count($issue_dates) . " issue_dates<hr/>";
//echo "file_body after issue_dates = " . $file_body . "<hr/>";
/********************************************************************
  end filling list of issue_dates

  now for each issue_date, get the number of issues each org has for that issue_date
********************************************************************/

foreach($issue_dates as &$this_issue_date){
  //echo "freech issue_dates = " . $this_issue_date . "<br/>";
  $issue_date_line = $this_issue_date;

  foreach($holders as &$this_org_id){
    $sql_data = 'SELECT COUNT(DISTINCT issue_date, format_id) AS issues_this_date_this_org FROM issues ';
    $sql_data .= 'WHERE pub_id = "' . $pub_id . '" ';
    $sql_data .= 'AND issue_date LIKE "' . $this_issue_date . '%" ';
    $sql_data .= 'AND org_id = "' . $this_org_id . '" ';
    //echo '<br/>' . $sql_data . '<br/>';
    $data_result  = @mysqli_query($conn, $sql_data) or die( mysqli_error($conn) );
    if (!$data_result) {
  		echo mysql_error();
  	} else {
  		while($data_row = mysqli_fetch_array($data_result, MYSQL_ASSOC)) {
        $issue_date_line .= ',' . $data_row['issues_this_date_this_org'];
      }// end while
    } // end else
  } // end foreach org_id

 /* how many total for the issue_date ? [ALL holders] */
  $sql_year_total = 'SELECT COUNT(DISTINCT issue_date, format_id) AS year_total FROM issues ';
    $sql_year_total .= 'WHERE pub_id = "' . $pub_id . '" ';
    $sql_year_total .= 'AND issue_date LIKE "' . $this_issue_date . '%" ';
  $year_total_result = @mysqli_query($conn, $sql_year_total) or die( mysqli_error($conn) );
  $yt_row = mysqli_fetch_array($year_total_result, MYSQL_ASSOC);
  $year_total = $yt_row['year_total'];

  $file_body .= $issue_date_line . ',' . $year_total . "\n";
}// end foreach issue_date

die($file_body);

mysqli_close($conn);
?>


<!--end get_org_info.php-->