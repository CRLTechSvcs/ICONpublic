<?php


  /*
    2014-09-25 AJE
      - display basic information about all publications in a given language
      - this page is called with a language_name in response to click on language pie slice in statistics.php
      - Google Charts don't yet handle extracting language_id from known language_name
        so we get name + the javascript will look up language_id before sending it to the PHP
      - javascript block is by page footer
  */


		$pub_id = 'sn84023370'; //dummy pub_id so lingering CJ scripts don't fail
    $language_name = $_REQUEST['language_name'];
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

      <div class="row twelve columns" id="reports_containers">
        <?php include "statistics_container_languages.html"; ?>
        <?php include "statistics_chart_canvas.html"; ?>

				<span class="pb_report_title iconTitleLong">Publications in language: </span>
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

            <div id="language_map_display_link" style="display:none;">
              <a href="#">show map of countries for these titles</a>
            </div>
            </span>
          </div>

<div class="twelve columns statistics_type_subheader">
    <span class="six columns">
       Publication title
    </span>
    <span class="four columns">City, Country</span>
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
  /* AJE 2014-09-25 this block is the meat of publications by language */

  start_progress( 1000 ); // statistics.js

 $.get("get_statistics_languages_static.php", prepareLanguages); //statistics.js: now we have languagesArray
 // 2015-10-22: this should exist now from statistics.js, and no need to call again
 //   actually do we need it at all here now in new version? is left from when diaplay*.php pages incorporated statistics header

  var pubs_in_language = [];

  function displayPublicationsByLanguage( pubs_in_languageJSON ){ // callback for: get_publications_by_language.php
    var strDebug = 'displayPublicationsByLanguage: ';
    pubs_in_language = JSON.parse( pubs_in_languageJSON );

    var pbc_language_name = extract_language_name_from_QString();

    $("#pbheader_title_count").html(pubs_in_language.length);
    $("#pbheader_title_count").addClass('pb_report_header_result');
    $("#pbheader_searching_name").addClass('pb_report_header_result');
    $("#click_title_hint").show();

    for (var i = 0; i < pubs_in_language.length; i++) {
      var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";

      var lang_href = '<a href="calendar.php?pub_id=' +pubs_in_language[i].pub_id+ '" target="_blank">';
      var pub_lang_div = '<div class="twelve columns" style="' +thisStyle+ '">';
        pub_lang_div += '<p class="six columns statisticsData">';
        //pub_lang_div += '<a href="calendar.php?pub_id=' +pubs_in_language[i].pub_id+ '" target="_blank">';
        pub_lang_div += lang_href + pubs_in_language[i].pub_title+ '</a></p>';
        pub_lang_div += '<p class="four columns statisticsData">' +pubs_in_language[i].pub_city+ ', ' +pubs_in_language[i].pub_country+ '</p>';
        pub_lang_div += '<p class="two columns statisticsData">' +pubs_in_language[i].pub_bgnDate+'&nbsp; to &nbsp;' +pubs_in_language[i].pub_endDate+ '</p>';

        pub_lang_div += '</div>';

      strDebug += "\n"+i+") " +pub_lang_div;

      $('#this_report_content').append($( pub_lang_div ));

    } // end for pubs_in_language

    //console.log('sve je u redu do tuka izvan loopa');

    $('#pb_report_progressBar').hide(); // wipe it out when complete

    //console.log('i pb_report_progressBar mora biti dobro');

  }//end displayPublicationsByLanguage


  var language_countries = [];

  function display_language_publications_map(language_country_JSON){

    language_countries = JSON.parse( language_country_JSON );

    var strDebug = 'display_language_publications_map has: language_country_JSON = \n' +language_country_JSON;
    //strDebug += '\nlanguage_countries = \n' +language_countries+ '\n has length: ' +language_countries.length;
    //console.warn(strDebug);

    var b_show_USA_map = false; var num_us_pubs = 0;
    var b_show_Canada_map = false; var num_canada_pubs = 0;
    for(var i=0; i<language_countries.length; i++){

      var regex_match = /..u/.test( language_countries[i].country_id );
      //strDebug = 'US regex_match = ' +regex_match;

      if ( ! b_show_USA_map &&  regex_match ) {
        b_show_USA_map = true;
        num_us_pubs = count_provinces( language_countries, /..u/ ); // statistics_countries.js
        //console.log('found b_show_USA_map = ', b_show_USA_map, ' ; num_us_pubs = ', num_us_pubs);
      }
      regex_match = /..c/.test( language_countries[i].country_id );
      if ( ! b_show_Canada_map && regex_match) {
        b_show_Canada_map = true;
        num_canada_pubs = count_provinces( language_countries, /..c/ )
        //console.log('found b_show_Canada_map = ', b_show_Canada_map, ' ; num_canada_pubs = ', num_canada_pubs);
      }
      //console.log(i, ') ', strDebug, '\nlanguage_countries[',i,'].country_id = ', language_countries[i].country_id, ' ; b_show_USA_map = ', b_show_USA_map, ' ; num_us_pubs = ', num_us_pubs, '  ; b_show_Canada_map = ', b_show_Canada_map, ' ; num_canada_pubs = ', num_canada_pubs );
    }// end for


      // add language_countries elements so totals for countries with provinces show on world map
    if(b_show_USA_map) {
      push_language_country("xxu", "United States", num_us_pubs, language_countries);
    }
    if(b_show_Canada_map) {
      push_language_country("xxc", "Canada", num_canada_pubs, language_countries);
    }

    setTimeout(function () { // just giving the chart enough time to render invisibly before showing
      google_visualization_map('world', 'language_map_canvas_world'); //Whole world
      if(b_show_USA_map){
        google_visualization_map('US', 'language_map_canvas_USA'); //United States, normal map
      }
      if(b_show_Canada_map){
        google_visualization_map('CA', 'language_map_canvas_Canada'); //Canada
      }
      // chartDisplay('#language_map_canvas'); // 2015-10-26 original line: just show it
      // instead now, show the link which will have it as its click event
      $('#language_map_display_link').click(function() {
        chartDisplay('#language_map_canvas');
      });
      $('#language_map_display_link').show();
    }, 1000  );
  } // end display_language_publications_map


$( document ).ready(function() {

  $("#pbheader_title_count").html('[retrieving]');

  var language_name = extract_language_name_from_QString();
  $("#pbheader_searching_name").html( language_name ); // set right away before call to get_publications_by_language.php
  //console.log('language_name after extract = ' +language_name);

  var language_id = "und";
  setTimeout(function () {
    for(i = 0; i < languagesArray.length; i++){
      //console.log('ln_', i, ') languagesArray[i].language_name = ', languagesArray[i].language_name);
      if (languagesArray[i].language_name == language_name){
        language_id = languagesArray[i].language_id;
        //console.info('language_id found == ', language_id);

        $.get("get_countries_by_language.php", { 'language_id': language_id }, display_language_publications_map);
        $.get("get_publications_by_language.php", { 'language_id': language_id }, displayPublicationsByLanguage);

        break;
      }// end if
    }// end for
    //console.info('language_id after languagesArray = ' +language_id);
  }, 2000
  );

}); // end doc.ready



</script>



	</body>
</html>