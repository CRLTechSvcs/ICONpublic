<?php


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
		<!--CRL statistics scripts:-->
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

			<div class="row twelve columns" id="reports_containers">
				<span class="pb_report_title iconTitleLong">Publications from: </span>
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
              publications

              <span id="click_title_hint"> ; click any title for details and holdings</span>

            </span>
          </div>

<div class="twelve columns statistics_type_subheader">
    <span class="six columns">
       Publication title
    </span>
    <span class="four columns">City</span>
    <span class="two columns">Publication dates</span>
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
  /* AJE 2014-09-25 this block is the meat of publications by country */

 //$.get("get_statistics_countries_static.php", prepareCountries); // statistics.js : now we have countriesArray
 // 2015-10-22: this should exist now from statistics.js, and no need to call again
 //   actually do we need it at all here now in new version? is left from when diaplay*.php pages incorporated statistics header

  var pubs_in_country = [];

  start_progress( 1000 ); // statistics.js

  function displayPublicationsByCountry( pubs_in_countryJSON ){ // callback for: get_publications_by_country.php
    var strDebug = 'displayPublicationsByCountry: ';
    pubs_in_country = JSON.parse( pubs_in_countryJSON );

    var pbc_country_name = extract_country_name_from_QString();

    $("#pbheader_title_count").html(pubs_in_country.length);
    $("#pbheader_title_count").addClass('pb_report_header_result');
    $("#pbheader_searching_name").addClass('pb_report_header_result');
    $("#click_title_hint").show();

    for (var i = 0; i < pubs_in_country.length; i++) {
      var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";

      var this_output_div = '<div class="twelve columns" style="' +thisStyle+ '">';
        this_output_div += '<p class="six columns statisticsData">';
        this_output_div += '<a href="calendar.php?pub_id=' +pubs_in_country[i].pub_id+ '" target="_blank">';
        this_output_div += pubs_in_country[i].pub_title+ '</a></p>';
        this_output_div += '<p class="four columns statisticsData">' +pubs_in_country[i].pub_city+ '</p>';
        this_output_div += '<p class="two columns statisticsData">' +pubs_in_country[i].pub_bgnDate+'&nbsp; to &nbsp;' +pubs_in_country[i].pub_endDate+ '</p>';
        this_output_div += '</div>';

      strDebug += "\n"+i+") " +this_output_div;

      $('#this_report_content').append($( this_output_div ));

    } // end for pubs_in_country

    $('#pb_report_progressBar').hide(); // wipe it out when complete

  }//end displayPublicationsByCountry


$( document ).ready(function() {

  $("#pbheader_title_count").html('[retrieving]');

  //console.info('displayPublicationsByCountry has doc.ready, calling get_s_c_static...')
  $.get("get_statistics_countries_static.php", prepareCountries); //call countries first so organizations can use it

  var country_name = extract_country_name_from_QString();
  $("#pbheader_searching_name").html( country_name ); // set right away before call to get_publications_by_country.php
  //console.info('country_name after extract = ' +country_name);

  var country_id = "xx";
  setTimeout(function () {
    for(i = 0; i < countriesArray.length; i++){
      if (countriesArray[i].country_name == country_name){
        // countries composed of multiple codes ('United States', etc) will be dealt with in get_publications_by_country.php
        country_id = countriesArray[i].country_id;
        $.get("get_publications_by_country.php", { 'country_id': country_id }, displayPublicationsByCountry);
        break;
      }// end if
    }// end for
    //console.info('country_id after countriesArray = ' +country_id);
  }, 2000
  );

}); // end doc.ready



</script>



	</body>
</html>