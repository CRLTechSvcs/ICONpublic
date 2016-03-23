<?php


  /*
    2014-09-25 AJE
      - display basic information about all publications held by a given org
      - this page is called with a org_name in response to click on org pie slice in statistics.php
      - Google Charts don't yet handle extracting org_id from known org_name
        so we get name + the javascript will look up org_id before sending it to the PHP
      - javascript block is by page footer
  */


		$pub_id = 'sn84023370'; //dummy pub_id so lingering CJ scripts don't fail
    $org_name = $_REQUEST['org_name'];
?>

<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en"><![endif]-->
<!--[if gt IE 8]><!--><html class="no-js" lang="en"><!--<![endif]-->
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />

    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />

		<title>International Coalition on Newspapers (ICON)</title>

		<script src="javascripts/jquery.js"></script>

		<!--https://www.google.com/jsapi is needed for Google Charts API-->
		<script src="https://www.google.com/jsapi"></script>
		<!--CRL versions of calls to Google Charts API are in next script: -->
		<script src="javascripts/googleChartsAPIfunctions.js"></script>
		<!--CRL statistics scripts: -->
		<script src="javascripts/statistics.js"></script>

		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/icon.css">

	</head>
	<body>
		<div class="row header" style="margin: 20px auto;">
<!-- CRL LOGO -->
			<div class="six columns" style="padding-left: 0px;">
				<a href="http://www.crl.edu"><img src="images/CRL_logo.png" /></a>
			</div>
<!-- ICON TEXT -->
			<div class="six columns" style="padding-right: 0px;">
				<h1 class="iconTitle iconTitleLong">International Coalition on Newspapers</h1>
				<h1 class="iconTitle iconTitleShort">ICON</h1>
			</div>
		</div>
		<div class="row contentArea">
<!-- MAIN CONTENT AREA -->
			<div class="twelve columns mainContentArea">
				<!-- <br/><div align="center"><img src="images/temp_main_content.jpg" width="591" /></div> -->
				<div id="content_wrapper">
					<div class="row" id="search_form">
						<div class="twelve columns" style="margin-bottom: 15px;">

              <?php include "statistics_new_search_link.html"; ?>

							<div class="row" id="top_search_form">
								<div class="row">

									<div class="seven columns">
									  <!--?php include("statistics_summary.html"); ?-->
									</div>

        					<div class="five columns" id="statistics_triggers">
        					  <!--?php include "statistics_triggers.html"; ?-->
        					</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row" id="message_container">
						<div class="eleven columns centered" id="message">
						</div>
					</div>
				</div>
			</div>

			<div class="row twelve columns" id="reports_containers"> <!-- statistics_chart_canvas etc would go here-->
				<span class="pb_report_title iconTitleLong">Publications held by: </span>
				<span class="pb_report_title iconTitleShort">
          <span id="pbheader_searching_name">
            <img src="images/loading_issue_info.gif" style="vertical-align: baseline;" />
          </span>
				</span>
			</div>


      <div class="row" id="pubs_by_criterion_containers">
        <div class="twelve columns" id="pubs_by_criterion_report">
          <div id="pb_report_progressBar" class="twelve columns"></div>
          <div class="twelve columns statistics_type_header">
            <span id="pb_report_header" class="twelve columns">
            ICON holdings:
            <span id="pbheader_title_count">
              <img src="images/loading_issue_info.gif" style="vertical-align: baseline;" />
            </span>

            <span id="click_title_hint"> ; click any title for details and holdings</span>

            </span>

          </div>

<div class="twelve columns statistics_type_subheader">
    <span class="six columns">
       Publication title
    </span>
    <span class="four columns">City, Country</span>
    <span class="two columns">pub. dates</span>
</div>
        	<div id="this_report_content" class="twelve columns"></div>

        </div>


      </div>

		</div>


<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php include("help_sort_button.php"); ?>

<?php include("footer_script_tags.php"); ?>


<script>
  /* AJE 2014-09-25 this block is the meat of publications by org */

 //$.get("get_statistics_organizations_static.php", prepareOrganizations); //statistics.js : now we have orgsArray
 // 2015-10-22: this should exist now from statistics.js, and no need to call again
 //   actually do we need it at all here now in new version? is left from when diaplay*.php pages incorporated statistics header

start_progress( 1000 ); // statistics.js

//$.get("get_publications_by_org_count.php", { 'org_id':org_id }, set_org_pub_count);
function set_org_pub_count( org_pub_countJSON ){
  //console.info('set_org_pub_count(', org_pub_countJSON, ')');
  var thisData = JSON.parse( org_pub_countJSON );
  org_pub_count = thisData[0].org_pub_count;

  var strDebug = 'set_org_pub_count has org_pub_count = ' +org_pub_count;

  $("#pbheader_title_count").text(org_pub_count);
  $('#pbheader_title_count').addClass('pb_report_header_result');
  //console.warn("NOT performing: $('#pbheader_title_count').addClass('pb_report_header_result');");

/*
  for( var p = 0; p < org_pub_count-1; p++){
    if (p != (org_pub_count-1) ){
      bar_percent = (p / org_pub_count) * 100;
    } else { bar_percent = 100; }

    bar_percent = Math.round( bar_percent );
    progress( bar_percent, "#pb_report_progressBar", bar_percent +"_"+p);

    if (p < 5 || p == (org_pub_count-1) || p == org_pub_count){ // reduce debugging messages on large sets
    console.log('set_org_pub_count: ', p, ') org_pub_count=', org_pub_count, ' ; bar_percent = ', bar_percent);
    }
  } // end for P = PROGRESS
*/
  //console.log(strDebug, ' : calls other AJAX next AFTER loop');
  $.get("get_publications_by_org.php", { 'org_id':org_id }, display_publications_by_org);
  //console.log(strDebug, ' : exiting');

}// end function set_org_pub_count

function display_publications_by_org( pubs_held_by_orgJSON ){ // callback for: get_publications_by_org.php
  var strDebug = 'display_publications_by_org: ' + pubs_held_by_orgJSON;
  pubs_held_by_org = JSON.parse( pubs_held_by_orgJSON );

  var num_pubs_from_org = pubs_held_by_org.length;
  var org_id            = pubs_held_by_org[0].org_id;

  $("#click_title_hint").show();

  var bar_percent = 100; // bar_percent must change
  for (var i = 0; i < pubs_held_by_org.length; i++) {
    var this_pub_id       = pubs_held_by_org[i].pub_id;
    var this_pub_title    = pubs_held_by_org[i].pub_title;
    var this_pub_location = pubs_held_by_org[i].pub_city  +', '+ pubs_held_by_org[i].country_name;
    var this_pub_dates    = pubs_held_by_org[i].pub_bgnDate +'&nbsp; to &nbsp;'+ pubs_held_by_org[i].pub_endDate;

    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var this_output_div = '<div class="twelve columns" style="' +thisStyle+ '">';
      this_output_div += '<p class="six columns statisticsData">';
      this_output_div += '<a href="calendar.php?pub_id='+ this_pub_id +'" target="_blank">';
      this_output_div += this_pub_title +'</a></p>';
      this_output_div += '<p class="four columns statisticsData">'+ this_pub_location +'</p>';
      this_output_div += '<p class="two columns statisticsData">'+ this_pub_dates +'</p>';
      this_output_div += '</div>';
    $('#this_report_content').append($( this_output_div ));

  } // end for pubs_held_by_org

  $('#pb_report_progressBar').hide(); // wipe it out when complete

}//end display_publications_by_org


$("#pbheader_title_count").html('[retrieving]');

$.get("get_statistics_organizations_static.php", prepareOrganizations); // statistics.js

var org_pub_count = 0;
var pubs_held_by_org = [];
var org_name  = get_org_NAME_from_URL(); //extract from query string: statistics.js
  $('#pbheader_searching_name').html(org_name);
  $('#pbheader_searching_name').addClass('pb_report_header_result');

var org_id    = "@@@"; // default dummy ; set below
setTimeout(function () { // takes a second to get the org_id back
  do {
    org_id    = get_org_ID_from_org_NAME( org_name ); // statistics.js
    //console.info( 'FIRST setTimeout has org_id = ', org_id, ' ; ');
  } while (org_id == "@@@");  // end while

  //console.info( 'FIRST setTimeout step 2: get_publications_by_org_count.php?org_id=', org_id, ' ; then set_org_pub_count(JSON) ');
  $.get("get_publications_by_org_count.php", { 'org_id':org_id }, set_org_pub_count); // do this get before adding the ajaxSend: ajaxSend will now only apply to calls after this
}, 4000 );




</script>


	</body>
</html>