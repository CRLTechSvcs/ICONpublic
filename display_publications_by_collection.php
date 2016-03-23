<?php


  /*

    2015-10-14 AJE
    - display basic information about all publications contained in a given collection
    start with a copy of display_publications_by_org.php
    - this page is called with collection_id in response to click on a collection link from calendar.php
      - so we don't have the problem of translating a name into an id as the original did

    2014-09-25 AJE
      - display basic information about all publications held by a given org
      - this page is called with a org_name in response to click on org pie slice in statistics.php
      - Google Charts don't yet handle extracting org_id from known org_name
        so we get name + the javascript will look up org_id before sending it to the PHP
      - javascript block is by page footer
  */


		$pub_id = 'sn84023370'; //dummy pub_id so lingering CJ scripts don't fail
    $collection_id = $_REQUEST['collection_id'];
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

		<script src="javascripts/collections.js"></script>

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
				<span class="pb_report_title iconTitleLong">Collection: </span>
				<span class="pb_report_title iconTitleShort">
          <span id="pbheader_collection_name">
            <img src="images/loading_issue_info.gif" style="vertical-align: baseline;" />
          </span>
				</span>
			</div>

      <div class="row" id="pubs_by_criterion_containers">
        <div class="twelve columns" id="pubs_by_criterion_report">
          <div id="pb_report_progressBar" class="twelve columns"></div>
          <div class="twelve columns statistics_type_header">
              <span id="pb_report_header" class="twelve columns">
                Organization: <span id="pbheader_this_org_profile"></span>
                  <br/>
                  See all titles held by: <span id="pbheader_this_org_pubs">&nbsp;</span>
                  <br/>
                  collections contain many publications: <span id="pbheader_title_count"></span> titles in this one
                <div id="click_title_hint">
                  <ul style="list-style-type: none;">
                  <li>click any publication below to see detailed holdings</li>
                  <li>a publication (or date range of one) may belong to many collections, sold by many vendors</li>
                  </ul>
                </div>
            </span>

          </div>

<div class="twelve columns statistics_type_subheader">
    <span class="six columns">
       Publication title
    </span>
    <span class="three columns">City, Country,<br/>Publication dates</span>
    <span class="three columns">vendor details</span>
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

var org_id            = "[...]";
var org_name          = "[...]";
var collection_name   = "[...]";

//$.get("get_statistics_organizations_static.php", prepareOrganizations); // statistics.js : now we have orgsArray

var pubs_in_collection = [];

start_progress( 1000 ); // statistics.js

function display_publications_by_collection( pubs_in_collectionJSON ){ // callback for: get_publications_by_org.php
  var strDebug = 'display_publications_by_collection: ';
   //strDebug += pubs_in_collectionJSON;

  pubs_in_collection = JSON.parse( pubs_in_collectionJSON );

  var org_id = pubs_in_collection[0].org_id;
  set_title_count(pubs_in_collection.length); // collections.js
  $("#click_title_hint").show();

  for (var i = 0; i < pubs_in_collection.length; i++) {
    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";

    var this_output_div = '<div class="twelve columns" style="' +thisStyle+ '">';

      this_output_div += '<p class="six columns statisticsData">';
      this_output_div += '<a href="calendar.php?pub_id=' +pubs_in_collection[i].pub_id+ '" target="_blank">';
      this_output_div += pubs_in_collection[i].pub_title+ '</a>';
      this_output_div += '</p>';

      this_output_div += '<p class="three columns statisticsData">';
        this_output_div += pubs_in_collection[i].pub_city+ ', ' +pubs_in_collection[i].country_name;
        this_output_div += '<br/>';
        this_output_div += pubs_in_collection[i].pub_bgnDate +'&nbsp; to &nbsp;'+ pubs_in_collection[i].pub_endDate;
      this_output_div += '</p>';

      this_output_div += '<ul class="three columns">';
          if(pubs_in_collection[i].pub_coll_note){

            var pcnote_array = pubs_in_collection[i].pub_coll_note.split(';');
            for(var n=0; n < pcnote_array.length; n++){
              var this_note = pcnote_array[n].replace(': ', ':<br/>');
              //this_output_div += '<li>'+ this_note +'</li>';

              var label = this_note.substr(0, this_note.indexOf(':<br/>')+6);
              var content = this_note.substr(this_note.indexOf(':<br/>')+6);
if(this_note.indexOf('109E40A8ADC79AC0') != -1){
console.log('109E40A8ADC79AC0 label = ', label, ' ; content = ', content);
}
              this_output_div += '<li>'+ label +'<span class="statisticsData">'+ content +'</span></li>';


            }//end for each piece of the note
          } // end if note

        this_output_div += '</ul>';
      this_output_div += '</div>';
    strDebug += "\n"+i+") " +this_output_div;

    $('#this_report_content').append($( this_output_div ));
  } // end for pubs_in_collection

  $('#pb_report_progressBar').hide(); // wipe it out when complete

}//end display_publications_by_collection

$( document ).ready(function() {

  $("#pbheader_this_org_profile").html('[retrieving organization]');
  $("#pbheader_this_org_pubs").html('[retrieving organization]');
  $("#pbheader_title_count").html('[retrieving count]');
  $("#pbheader_collection_name").html('[retrieving name]');
  $("#pbheader_collection_name_for_title").html('[retrieving name]');

  // extract collection_id from URL
  var thisURL       = window.location.search;
  var collection_id = unescape( thisURL.substring( thisURL.indexOf("collection_id=")+14) );
  //console.info('qstring block: collection_id final = ' +collection_id);

  setTimeout(function () { // takes a bit to get the collection_name back
    do {
      setTimeout(function () { var junk = "waiting for collection_name"; }, 100 );
    } while (collection_name == "");  // end while
    $.get("get_collection_name_from_id.php", { 'collection_id':collection_id }, set_collection_name); // collections.js
  }, 1000 );

  setTimeout(function () { // takes a bit to get the org_name back
    do {
      setTimeout(function () { var junk = "waiting for org_name"; }, 200 );
    } while (collection_name == "");  // end while
    $.get("get_collection_org_from_id.php", { 'collection_id':collection_id }, set_org_name);  // collections.js
  }, 1000 );

  setTimeout(function () { // takes a bit to get the collection_id back
    /*
    do {
      org_id    = get_org_ID_from_org_NAME( org_name ); // statistics_organizations.js
      setTimeout(function () { var junk = "waiting for org_id"; }, 5000 );
    } while (org_id == "@@@");  // end while
    */
    $.get("get_publications_by_collection.php", { 'collection_id':collection_id }, display_publications_by_collection);
  }, 500 );

}); // end doc.ready



</script>



	</body>
</html>