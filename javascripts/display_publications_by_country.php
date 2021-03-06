﻿<?php


  /*
    2014-09-25 AJE
      - display basic information about all publications in a given country
      - this page is called with a country_name in response to click on country pie slice in statistics.php
      - Google Charts don't yet handle extracting country_id from known country_name
        so we get name + the javascript will look up country_id before sending it to the PHP
      - javascript block is by page footer
  */


		$pub_id = 'sn84023370'; //dummy pub_id so lingering CJ scripts don't fail
    $country_name = $_REQUEST['country_name'];
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
		<script src="javascripts/statistics_countries.js"></script>
		<script src="javascripts/statistics_formats.js"></script>
		<script src="javascripts/statistics_organizations.js"></script>
		<script src="javascripts/statistics_years.js"></script>

		<link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />
		<link rel="stylesheet" href="stylesheets/foundation.min.css">
		<link rel="stylesheet" href="stylesheets/icon.css">

	</head>
	<body>
		<div class="row header" style="margin: 20px auto;">
<!-- CRL LOGO -->
			<div class="six columns" style="padding-left: 0px;">
				<a href="http://www.crl.edu"><img src="images/logo.gif" /></a>
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
									  <?php include("statistics_summary.html"); ?>
									</div>

        					<div class="five columns" id="statistics_triggers">
        					  <?php include "statistics_triggers.html"; ?>
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

      <div class="row" id="reports_containers">
        <?php include "statistics_chart_canvas.html"; ?>
        <?php include "statistics_container_orgs.html"; ?>
        <?php include "statistics_container_countries.html"; ?>
        <?php include "statistics_container_years.html"; ?>
        <?php include "statistics_container_formats.html"; ?>
      </div>

      <div class="row" id="pubs_by_criterion_containers">
        <div class="twelve columns" id="pubs_by_country_report"">

          <div class="twelve columns statistics_type_header">

            <span id="pubs_by_country_report_header" class="twelve columns statistics_type_header">
              ICON holdings:

              <span id="pbc_header_country_count_loading">
                <img src="images/loading_issue_info.gif" style="vertical-align: baseline;" />
              </span>
              <span id="pbc_header_country_count"></span>

              publications from
              <span id="pbc_header_country_name_loading">
                <img src="images/loading_issue_info.gif" style="vertical-align: baseline;" />
              </span>

              <span id="pbc_header_country_name"></span>

              <span id="click_title_hint"> ; click titles for full details</span>

            </span>
          </div>

        	<div class="twelve columns" id="pubs_by_country_report_content">
        	</div>

        </div>
      </div>

		</div>


<!-- FOOTER -->
<?php include("footerCRL.html"); ?>

<?php include("help_sort_button.php"); ?>

<?php include("footer_script_tags.php"); ?>


<script>
  /* AJE 2014-09-25 this block is the meat of publications by country */

  //statistics_countries.js
 $.get("get_statistics_countries_static.php", prepareCountries); //now we have countriesArray

  var pubs_in_country = [];

  function displayPublicationsByCountry( pubs_in_countryJSON ){ // callback for: get_publications_by_country.php
    var strDebug = 'displayPublicationsByCountry in the hUUUs\n';
    pubs_in_country = JSON.parse( pubs_in_countryJSON );

    var pbc_country_name = extract_country_name_from_QString();

    $("#pbc_header_country_count_loading").hide();
    $("#pbc_header_country_count").text(pubs_in_country.length);
    $("#pbc_header_country_name_loading").hide();
    $("#pbc_header_country_name").text( pbc_country_name );
    $("#click_title_hint").show();


    for (var i = 0; i < pubs_in_country.length; i++) {
      var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";

      var pub_ctry_div = '<div class="twelve columns" style="' +thisStyle+ '">';
        pub_ctry_div += '<p class="six columns statisticsData">';
        pub_ctry_div += '<a href="calendar.php?pub_id=' +pubs_in_country[i].pub_id+ '" target="_blank">';
        pub_ctry_div += pubs_in_country[i].pub_title+ '</a></p>';
        pub_ctry_div += '<p class="four columns statisticsData">' +pubs_in_country[i].pub_city+ '</p>';
        pub_ctry_div += '<p class="two columns statisticsData">' +pubs_in_country[i].pub_bgnDate+'-' +pubs_in_country[i].pub_endDate+ '</p>';
        pub_ctry_div += '</div>';

      strDebug += "\n"+i+") " +pub_ctry_div;

      $('#pubs_by_country_report_content').append($( pub_ctry_div ));

    } // end for pubs_in_country
    //alert(strDebug);

  }//end displayPublicationsByCountry


$( document ).ready(function() {


  var country_name = extract_country_name_from_QString();
  //console.log('country_name after extract = ' +country_name);

  var country_id = "xx";
  setTimeout(function () {
    for(i = 0; i < countriesArray.length; i++){
      if (countriesArray[i].country_name == country_name){
        // countries composed of multiple codes ('United States', etc) will be dealt with in get_publications_by_country.php
        country_id = countriesArray[i].country_id;
        //alert(country_id);
        $.get("get_publications_by_country.php", { 'country_id': country_id }, displayPublicationsByCountry);
        break;
      }// end if
    }// end for
    console.log('country_id after countriesArray = ' +country_id);
  }, 2000
  );

}); // end doc.ready



</script>



	</body>
</html>