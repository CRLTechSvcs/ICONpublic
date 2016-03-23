/*
  AJE 2013-08-19 17:25:33
  this script in external file so same version can be used by
    statistics.php and statistics_live.php
*/

//var b_is_static_page = (location.href.indexOf("static") != -1) ? true : false;
var b_is_static_page = true; // 2014-08-29 disabled static vs. live distinction
var staticDate = "December 2015"; //last time static data was harvested and prepared for display
var staticAddress = "statistics.php";
var liveAddress = "statistics_live.php";
var thisPageTitle = "";
var staticNoteText = 'as of ' +staticDate+ ' ';
var loadedVersionText = "";
var loadingSpeedNoteText = '(slow due to database size)';
var otherVersionText = "";
if (b_is_static_page){
  thisPageTitle = 'ICON database statistics';
  loadedVersionText = ' ' +staticNoteText;
  otherVersionText = 'live data available ' +loadingSpeedNoteText;
} else {
  thisPageTitle = 'ICON live database statistics';
  loadedVersionText = 'Live data ' +loadingSpeedNoteText;
  otherVersionText += staticNoteText+ ' available';
}

var reports = new Array("#countries_report", "#organizations_report", "#formats_report", "#years_report", "#languages_report");
var loadingDivs = new Array("#loading-countries", "#loading-organizations", "#loading-formats", "#loading-years", "#loading-languages");

function reportDisplay( thisReportID ){ // show or hide page sections with statistical data
	var strDebug = "reportDisplay function has reports array: \nthisReportID = " + thisReportID;
	  strDebug += "\n b_is_static_page = " + b_is_static_page + "\n";

	for (var i=0; i<reports.length; i++){
		strDebug += "\n" +i+ ") " + reports[i];
		if (reports[i] != thisReportID){
			$(reports[i]).hide();
			strDebug += " to hide. ";
		} else {
			$(reports[i]).show();
			strDebug += " to SHOW. ";
		} //end if
	} //end for

	//console.warn(strDebug);
} //end reportDisplay


var charts = new Array(
  "#statistics_chart_canvas_pieWorld", "#statistics_chart_canvas_pieUSA",

  "#statistics_chart_canvas_wholeWorldMap",
  "#statistics_chart_canvas_NorthAmericaMap", "#statistics_chart_canvas_CanadaMap", "#statistics_chart_canvas_UnitedStatesMap",
  "#statistics_chart_canvas_CentralAmericaMap", "#statistics_chart_canvas_CaribbeanMap", "#statistics_chart_canvas_SouthAmericaMap",
  "#statistics_chart_canvas_GreatBritainMap", "#statistics_chart_canvas_AllEuropeMap",
  "#statistics_chart_canvas_AfricaMap", "#statistics_chart_canvas_MiddleEastMap",
  "#statistics_chart_canvas_AllAsiaMap", "#statistics_chart_canvas_OceaniaMap", "#statistics_chart_canvas_AustraliaMap",

  "#statistics_chart_canvas_orgs", "#statistics_chart_canvas_formats",
  "#statistics_chart_canvas_years", "#statistics_chart_canvas_languages",
  "#language_map_canvas"
);
function chartDisplay( thisChartID ){ // show or hide page sections with Google Charts
	var strDebug = "chartDisplay function has charts array: \nthisChartID = " + thisChartID;
	  strDebug += "\n b_is_static_page = " + b_is_static_page + "\n";

	for (var i=0; i<charts.length; i++){
		strDebug += "\n" +i+ ") " + charts[i];
		if (charts[i] != thisChartID){
			$(charts[i]).hide();
			strDebug += " to hide. ";
		} else {
			$(charts[i]).show();
			strDebug += " to SHOW. ";
		} //end if
	} //end for

	//console.info(strDebug);
} //end chartDisplay

function addCommasToNumString(nStr){ // after: http://www.mredkj.com/javascript/numberFormat.html
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
	  x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}//end addCommasToNumString




function preparePubsIssuesCounts(pubIssJSON){
  var pubsIssuesCountsArray = JSON.parse(pubIssJSON);
  var strDebug = "preparePubsIssuesCounts(\n\t" +pubIssJSON+ "\n) \n has length " +pubsIssuesCountsArray.length;
  var countPubs = -1;
  var countIssues = -1;
  for (var i = 0; i < pubsIssuesCountsArray.length; i++) {
    strDebug += "\npubsIssuesCountsArray["+i+"]=" +pubsIssuesCountsArray[i];
    countPubs = pubsIssuesCountsArray[i].countPubs;
    countIssues = pubsIssuesCountsArray[i].countIssues;
  }//end for
  strDebug += "\nafter loop: pub = " +countPubs+ "\ncountIssues = " +countIssues;

  $("#publicationsCountValue").html( addCommasToNumString(countPubs) );
  $("#issuesCountValue").html( addCommasToNumString(countIssues) );
  //alert( strDebug );
} //end preparePubsIssuesCounts



$(document).ready(function() {

  $("#statistics_title").text( thisPageTitle );
  $("#loadedVersionNote").text(loadedVersionText);
  $("#other_version_trigger").html(otherVersionText);
  $.get("get_issues_and_publications_counts.php", preparePubsIssuesCounts);

  if( b_is_static_page ){ //load static JSON from the given files
    $.get("get_statistics_countries_static.php", prepareCountries); //call countries first so organizations can use it
    /*
      2014-08-29
      functions: prepareOrganizations, prepareYears, prepareFormats now include calls to google_visualization_chart in googleChartsAPIfunctions.js
    */
    $.get("get_statistics_organizations_static.php", prepareOrganizations);
    $.get("get_statistics_years_static.php", prepareYears);
    $.get("get_statistics_formats_static.php", prepareFormats);
    $.get("get_statistics_languages_static.php", prepareLanguages);
  } else { //load live JSON from the database
      $.get("get_statistics_countries.php", prepareCountries); //call countries first so organizations can use it
      /*
        2014-08-29
        functions: prepareOrganizations, prepareYears, prepareFormats now include calls to google_visualization_chart in googleChartsAPIfunctions.js
      */
      $.get("get_statistics_organizations.php", prepareOrganizations);
      $.get("get_statistics_years.php", prepareYears);
      $.get("get_statistics_formats.php", prepareFormats);
      $.get("get_statistics_languages.php", prepareLanguages);
  } //end if


  /* AJE 2013-11-08 15:00:55
    - add slider functionality to statistics triggers list elements to display sublists that can show maps
    - http://api.jquery.com/slideDown/
    - http://api.jquery.com/slideUp/
  */
  /*
  $( "#country_count_trigger" ).click(function () {
  if ( $( "#country_count_charts_list" ).is( ":hidden" ) ) {
    $( "#country_count_charts_list" ).slideDown( "slow" );
  } else {
    $( "#country_count_charts_list" ).slideUp( "slow" );
  }
  });
  */






});//end doc.ready func