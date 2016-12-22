<?php

  /*

    2015-10-14 AJE
    - display basic information about all collections from a given org (vendor)
    start with a copy of display_collections_by_org.php
    - this page is called with org_id in response to click on an org/collection link from calendar.php
      - so we don't have the problem of translating a name into an id as the original did
    - javascript block is by page footer
  */

		$pub_id = 'sn84023370'; //dummy pub_id so lingering CJ scripts don't fail
    $org_id = $_REQUEST['org_id'];
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
				<span class="pb_report_title iconTitleLong">Collections from: </span>
				<span class="pb_report_title iconTitleShort">
          Organization: <span id="pbheader_this_org_profile"></span>
				</span>
			</div>

      <div class="row" id="pubs_by_criterion_containers">
        <div class="twelve columns" id="pubs_by_criterion_report">
          <div id="pb_report_progressBar" class="twelve columns"></div>
          <div class="twelve columns statistics_type_header">
            <span id="pb_report_header" class="twelve columns">
                Number of collections: <span id="pbheader_title_count"></span>
                &nbsp;&nbsp;
                See all titles held by: <span id="pbheader_this_org_pubs">&nbsp;</span>
              <div id="click_title_hint">
                <ul style="list-style-type:none;">
                <li>collections contain many publications: click any collection title below to see publications included</li>
                <li>a publication (or date range of one) may belong to many collections, sold by many vendors</li>
                </ul>
              </div>
            </span>
          </div>

<div class="twelve columns statistics_type_subheader">
    <span class="eight columns">
       Collection title / <br/>Alternative title
    </span>
    <span class="four columns">vendor details</span>
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

// extract org_id from URL
var thisURL       = window.location.search;
var org_id = unescape( thisURL.substring( thisURL.indexOf("org_id=")+7) );
var org_name          = '';
var collection_name   = '';

//console.info('qstring block: org_id final = ' +org_id);

start_progress( 1000 ); // statistics.js

$("#pbheader_this_org_profile").html('[retrieving organization]');
$("#pbheader_this_org_pubs").html('[retrieving organization]');
$("#pbheader_title_count").html('[retrieving count]');

//$.get("get_statistics_organizations_static.php", prepareOrganizations); //statistics.js : now we have orgsArray

var collections_from_org = [];

function display_collections_by_org( collections_from_orgJSON ){ // callback for: get_publications_by_org.php
  var strDebug = 'display_collections_by_org u KUUUCI: ';
   //strDebug += collections_from_orgJSON;

  collections_from_org = JSON.parse( collections_from_orgJSON );

  for (var i = 0; i < collections_from_org.length; i++) {

    var coll_id         = collections_from_org[i].collection_id;
    var coll_org_id     = collections_from_org[i].collection_org_id;
    var coll_org_name   = collections_from_org[i].collection_org_name;
    var coll_title_one  = collections_from_org[i].collection_title_one;
    /*
    // AJE 2016-05-10 16:27:22
    var coll_title_two  = collections_from_org[i].collection_title_two;
    */
    var coll_title_two  = "";
    if ((collections_from_org[i].collection_title_two) &&
      (coll_title_one != collections_from_org[i].collection_title_two)) {
      coll_title_two  = collections_from_org[i].collection_title_two;
    } /* else console.warn('AJE 2016-05-10 coll_title_one = ', coll_title_one, ' ; coll_title_two=', coll_title_two); */


    var coll_format     = collections_from_org[i].collection_format;
    var coll_country    = collections_from_org[i].collection_country;
    var coll_home_uri   = collections_from_org[i].collection_home_uri;
    var coll_CRLprofile_uri = collections_from_org[i].collection_CRLprofile_uri;
    var coll_update_date    = collections_from_org[i].collection_update_date;
    var coll_note       = collections_from_org[i].collection_note;

    if (i == 0){
      // first time through, set the header
      $.get("get_collection_org_from_id.php", { 'collection_id':coll_id }, set_org_name);  // collections.js
    }

    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var this_output_div = '<div class="twelve columns" style="' +thisStyle+ '">';
      this_output_div += '<p class="eight columns statisticsData">';
        this_output_div += '<a href="display_publications_by_collection.php?collection_id=' +coll_id+ '" ';
        this_output_div += 'style="' +thisStyle+ '" target="_blank">';
        this_output_div += coll_title_one+ '</a>';
        if(coll_title_one != coll_title_two){
            this_output_div += '<br/><a href="display_publications_by_collection.php?collection_id=' +coll_id+ '" ';
            this_output_div += 'style="' +thisStyle+ '" target="_blank">';
            this_output_div += coll_title_two+ '</a>';
        } // end if titles

      // 2015-10-15 there is space in the UI to add more info about the collection
      this_output_div += '</p>'; // end container of collection title data

      this_output_div += '<ul class="four columns">';
      if (coll_format){
        this_output_div += '<li>Format: <span class="statisticsData">'+ coll_format + '</span></li>';
      }
      if (coll_country){
        this_output_div += '<li>Subject geo.: <span class="statisticsData">'+ coll_country + '</span></li>';
      }
      if (coll_home_uri){
        this_output_div += '<li><a href="'+ coll_home_uri +'" target="_blank">vendor page</a>&nbsp;';
        this_output_div += '<a href="'+ coll_home_uri +'" target="_blank"><img src="http://icon.crl.edu/images/external.png" /></a>';
        this_output_div += '</li>';
      }
      /*
      // this is already in header
      if (coll_CRLprofile_uri){
        this_output_div += '<li>';
        this_output_div += '<a href="'+ coll_CRLprofile_uri+'" target="_blank">CRL profile of this collection</a></li>';
      }
      */
      if (coll_note){
        this_output_div += '<li><span class="statisticsData">'+ coll_note + '</span></li>';
      }
      // var CRL_profile_url = get_org_profile_url( coll_org_id );
      //var CRL_profile_image = get_org_profile_image( coll_org_id );
      var CRL_profile_text  = get_linked_profile_text( coll_org_id, coll_org_name );
      var CRL_profile_image = get_linked_profile_image( coll_org_id, coll_org_name );
      //if(CRL_profile_url){
      if(CRL_profile_text){
        this_output_div += '<li>CRL profile of: ';
          //this_output_div += '<a href="'+ CRL_profile_url + '" target="_blank">'+ CRL_profile_image +'</a>&nbsp;';
          //this_output_div += '<a href="'+ CRL_profile_url + '" target="_blank">'+ coll_org_name +'</a>';
          this_output_div += CRL_profile_text + CRL_profile_image;
        this_output_div += '</li>';
      }
      this_output_div += '<li>as of: <span class="statisticsData">'+ coll_update_date + '</span></li></ul>';
      this_output_div += '</div>';

    strDebug += "\n"+i+") " +this_output_div;
    $('#this_report_content').append($( this_output_div ));

    set_title_count(collections_from_org.length); // collections.js
    $("#click_title_hint").show();

      //collections.js
    var org_profile_link = '<a href="'+ get_org_profile_url( coll_org_id ) +'">';
      org_profile_link += coll_org_name;
      org_profile_link += '</a><a href="'+ get_org_profile_url( coll_org_id ) +'">';
      org_profile_link += get_linked_profile_image( coll_org_id, coll_org_name );
      org_profile_link += +'</a>';
      //collections.js
    $("#pbheader_this_org_profile").html(org_profile_link);

    var org_publications_link = get_org_publications_link( coll_org_id, coll_org_name );
    $("#pbheader_this_org_pubs").html(org_publications_link);

  } // end for collections_from_org

  $('#pb_report_progressBar').hide(); // wipe it out when complete

}//end display_collections_by_org


$( document ).ready(function() {
  //$.get("get_collection_name_from_id.php", { 'collection_id':collection_id }, set_collection_name);
  $.get("get_collections_by_org.php", { 'org_id':org_id }, display_collections_by_org); // collections.js
}); // end doc.ready

</script>



	</body>
</html>