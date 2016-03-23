/*
  AJE 2013-08-19 17:25:33
  this script in external file so same version can be used by
    statistics.php and statistics_live.php
*/

var b_is_display_page = (location.href.indexOf("display") != -1) ? true : false;
//console.info('b_is_display_page = ', b_is_display_page);

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


/******************************************************************************************/
// a couple of utility functions that may belong elsewhere
function extract_keyword_from_QString(){
  var keyword = window.location.search; //extract from query string
  keyword = unescape(
    keyword.substring(
      keyword.indexOf("keyword=")+8
    )
  );
  return keyword;
} //end extract_country_name_from_QString
function extract_country_name_from_QString(){
  var country_name = window.location.search; //extract from query string
  country_name = unescape(
    country_name.substring(
      country_name.indexOf("country_name=")+13
    )
  );
  return country_name;
} //end extract_country_name_from_QString
function extract_language_name_from_QString(){
  var language_name = window.location.search; //extract from query string
  language_name = unescape(
    language_name.substring(
      language_name.indexOf("language_name=")+14
    )
  );
  return language_name;
} //end extract_language_name_from_QString
function push_language_country(country_id, country_name, country_pubs, target_array){
  var this_lang_ctry = new Object();
  this_lang_ctry.country_id = country_id ;
  this_lang_ctry.country_name = country_name;
  this_lang_ctry.country_pubs = country_pubs;
  target_array.push( this_lang_ctry );
}
// end couple of utility functions that may belong elsewhere
/******************************************************************************************/



/******************************************************************************************/
var countriesArray = Array(); // countriesArray is made useable in prepareCountries, used by others inclduing: prepareOrganizations and Google Charts API
// countriesArray is all including US states
var USstatesArray = Array(); // only US states (duh)
var CanadianProvincesArray = Array(); // only ... Canadian provinces!
var UKcountriesArray = Array(); // only captive countries of the United Kingdom, and England
var AustralianStatesArray = Array();
var otherCountriesArray = Array(); // NOT US states

// AJE 2015-07-30 count_provinces returns total number of publications for country composed of states or provinces
function count_provinces( language_countries, parent_country_regex ){
  var num_provinces = 0;
  var strDebug = 'count_provinces( language_countries, ' +parent_country_regex+ ' )\n';
    for(var i=0; i<language_countries.length; i++){ // language_countries is array from JSON
      var regex_match = language_countries[i].country_id.match(parent_country_regex);
      //strDebug += '\n' +i+ ') ' +language_countries[i].country_id+ ' ; FUNC PLUS regex_match = ' +regex_match;
      if ( regex_match ) {
        num_provinces += language_countries[i].country_pubs;
      }
    }// end for
  //console.info( strDebug, ' ; end with num_provinces = ', num_provinces );
  return num_provinces;
}// end count_provinces


function prepareCountries(countryJSON){ // see get_countries.php by CJ
  var strDebug = "prepareCountries(\n\tcountryJSON\n)";
  countriesArray = JSON.parse(countryJSON);
  for (var i = 0; i < countriesArray.length; i++) {

    /* IS THIS A COUNTRY COMPOSED OF MULTIPLE COUNTRY CODES?
      FILL SEPARATE ARRAYS SO THE NUMBERS SHOW CORRECTLY ON MAPS */


    var thisID = countriesArray[i].country_id;
    if (thisID.length == 3){

        // is it a US state?
        if ((thisID.charAt(thisID.length - 1) == 'u') && thisID != 'xxu') {
        //if ((thisID.length == 3) && (thisID.charAt(thisID.length - 1) == 'u') && thisID != 'xxu') {
          // test is: 3 characters long, ending in 'u', but not 'xxu' which is all US states plus D.C. plus unknown state
          USstatesArray[USstatesArray.length] = countriesArray[i];
        //} else if (thisID == 'xxu') {
        //  otherCountriesArray[otherCountriesArray.length] = countriesArray[i];
        } // end USstatesArray

        // is it a Canadian province?
        if ((thisID.charAt(thisID.length - 1) == 'c') && thisID != 'xxc') {
          CanadianProvincesArray[CanadianProvincesArray.length] = countriesArray[i];
        } else if (thisID == 'xxc'){ // YES add Canadian provinces to otherCountriesArray
          otherCountriesArray[otherCountriesArray.length] = countriesArray[i];
        } // end CanadianProvincesArray

        // is it a captive country of the United Kingdom?
        if ((thisID.charAt(thisID.length - 1) == 'u') && thisID != 'xxk') {
          UKcountriesArray[UKcountriesArray.length] = countriesArray[i];
        } else if (thisID == 'xxk'){ // YES add captive UK countries to otherCountriesArray
          otherCountriesArray[otherCountriesArray.length] = countriesArray[i];
        } // end UKcountriesArray

        // is it an Australian state or territory?
        if ((thisID.charAt(thisID.length - 1) == 'a') && thisID != 'at') {
          AustralianStatesArray[AustralianStatesArray.length] = countriesArray[i];
        } else if (thisID == 'at'){
          otherCountriesArray[otherCountriesArray.length] = countriesArray[i]; // YES adding Australian states to otherCountriesArray
        } // end AustralianStatesArray

    } else {
      otherCountriesArray[otherCountriesArray.length] = countriesArray[i];
    } // end if thisID is 3 characters

    /* END COUNTRIES COMPOSED OF MULTIPLE COUNTRY CODES */

    // below is what worked before 2014-08-29 when added USstatesArray and otherCountriesArray

    //countriesArray[i].issue_dates may be null; add a note if it is
    var countryIssueDates = (countriesArray[i].issue_dates) ? '<span class="statisticsData">'+countriesArray[i].issue_dates+'</span>' : '[processing for future]';
    var country_name      = countriesArray[i].country_name;
    var country_id        = countriesArray[i].country_id;
    var country_href = '<a href="display_publications_by_country.php?country_name=' +country_name+ '" class="statisticsData">';

    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var ctryDiv = '<div class="twelve columns" style="' +thisStyle+ '">';
    ctryDiv += '<p class="six columns statisticsData"><!--' +countriesArray[i].country_id+ '-->';
      /*
      ctryDiv += '<a href="display_publications_by_country.php?country_name=' +country_name+ '" ';
      ctryDiv += 'class="statisticsData">';
      ctryDiv += '<p class="two columns statisticsData">' +addCommasToNumString( countriesArray[i].country_pubs )+ '</p>'; //addCommasToNumString lives in statistics.js
      ctryDiv += '<p class="two columns statisticsData">' +addCommasToNumString( countriesArray[i].country_issues )+ '</p>';
      */
    ctryDiv += country_href + country_name+ '</a></p>';
    ctryDiv += '<p class="two columns statisticsData">'+ country_href + addCommasToNumString( countriesArray[i].country_pubs )+ '</a></p>'; //addCommasToNumString lives in statistics.js
    ctryDiv += '<p class="two columns statisticsData">'+ country_href + addCommasToNumString( countriesArray[i].country_issues )+ '</a></p>';


    ctryDiv += '<p class="two columns">' +countryIssueDates+ '</p>';
    ctryDiv += '</div>';

    strDebug += "\n"+i+") " +ctryDiv;
    $('#countries_report_content').append($( ctryDiv ));
  } //end for

  // 2015-10-22 :
  if( b_is_display_page ){
    //console.log('prepareCountries will exit, having appended the div, and not wanting to call Google maps API on a display page');
    return true;
  }


  strDebug += 'USstatesArray with ' +USstatesArray.length+ ' elements\n';
  strDebug += 'otherCountriesArray with ' +otherCountriesArray.length+ ' elements';


  //NOTE: actually showing the report is left to trigger link's click function

  //NOTE: showing maps from Google Charts API is called by trigger list item's sublists

    // pie charts
  google_visualization_chart( 'Percent of publications by country (excluding United States)', 'Country', 'Publications', 'otherCountriesArray', 'pie', 'statistics_chart_canvas_pieWorld');
  google_visualization_chart( 'Percent of publications by US state (only US publications)', 'Country', 'Publications', 'USstatesArray', 'pie', 'statistics_chart_canvas_pieUSA');

    // maps: load them all and they are ready
  google_visualization_map('world', 'statistics_chart_canvas_wholeWorldMap'); //Whole world
  google_visualization_map('021', 'statistics_chart_canvas_NorthAmericaMap'); //North America
  google_visualization_map('CA', 'statistics_chart_canvas_CanadaMap'); //Canada
  google_visualization_map('US', 'statistics_chart_canvas_UnitedStatesMap'); //United States, normal map

  // region '419' should be 'Latin America and the Caribbean' acc. to http://en.wikipedia.org/wiki/UN_M.49
  // would be nice for reducing the number of triggers and sub-maps but returns a 404 in Firebug and a blank map
  google_visualization_map('013', 'statistics_chart_canvas_CentralAmericaMap'); //Central America
  google_visualization_map('029', 'statistics_chart_canvas_CaribbeanMap'); //Caribbean
  google_visualization_map('005', 'statistics_chart_canvas_SouthAmericaMap'); //South America

  // region '150' AllEuropeMap means we can skip the excessive granularity of the extra maps:
  //  Great Britain is necessary to show the titles held in the individual captive countries of the UK
  google_visualization_map('GB', 'statistics_chart_canvas_GreatBritainMap'); // Great Britain
  google_visualization_map('150', 'statistics_chart_canvas_AllEuropeMap'); // like it sounds
  google_visualization_map('002', 'statistics_chart_canvas_AfricaMap'); // Africa
  google_visualization_map('145', 'statistics_chart_canvas_MiddleEastMap'); // Middle East
  google_visualization_map('142', 'statistics_chart_canvas_AllAsiaMap'); // like it sounds
  google_visualization_map('009', 'statistics_chart_canvas_OceaniaMap'); // Oceania
  google_visualization_map('AU', 'statistics_chart_canvas_AustraliaMap'); // Australia

    //change the image: this should be the last thing in the function, after all the maps are loaded
  $("#country_count_trigger").css("list-style-image", "url('')"); //loading image
} //end prepareCountries
/******************************************************************************************/




/******************************************************************************************/
var orgsArray = Array(); // made useable in prepareOrganizations: declared here so also visible to Google Charts API

function prepareOrganizations(orgsJSON){
  var strDebug = "prepareOrganizations(\n\t +orgsJSON+ \n)";

  //$("#orgs_report_content").html(orgsJSON); //down and dirty; works
  orgsArray = JSON.parse(orgsJSON);
  for (var i = 0; i < orgsArray.length; i++) {

      //in org_opac_uri, replace backslash globally with nothing so links are clickable
    var backslashRegex = /[\\]/g; //regex for backslash, global
    var org_home_uri = new String(orgsArray[i].org_home_uri).replace(backslashRegex, "");

    var org_name  = orgsArray[i].org_name;
    var org_id    = orgsArray[i].org_id;
    var orgTooltip = "organization: " +org_id+ ", " +orgsArray[i].org_address;

    var href_to_pubs_by_org = '<a href="display_publications_by_org.php?org_name=';
      href_to_pubs_by_org += org_name +'" ';
	    href_to_pubs_by_org += 'target="_blank" class="statistics_info_link" ';
	    href_to_pubs_by_org += 'title="see all titles from ' +orgTooltip+ '">'

    var orgDisplayName = href_to_pubs_by_org + org_name +'</a><br/>';

    /* old, updated 2015-10-21 : moved down by city/country block
    var orgDisplayName = '';
    if (org_home_uri){
	    orgDisplayName = '<a href="' +org_home_uri+ '" ';
	    orgDisplayName += 'target="_blank" class="statistics_info_link" ';
	    orgDisplayName += 'title="' +orgTooltip+ '">' +org_name+ '</a><br/>';
    } else {
	    orgDisplayName = '<span class="statistics_info_link" ';
	    orgDisplayName += 'title="' +orgTooltip+ '">' +org_name+ '</span><br/>';
    }
    */



//console.log('orgDisplayName[i=' +i+ '] = ' +orgDisplayName);

    var orgCountryName = '';
    for (var c = 0; c < countriesArray.length; c++) {
      if (orgsArray[i].country_id == countriesArray[c].country_id) {
        orgCountryName = countriesArray[c].country_name;
      }//end if
    }//end for countriesArray

      //orgsArray[i].issue_dates may be null; add a note if it is
    var orgIssueDates = (orgsArray[i].issue_dates) ? '<span class="statisticsData">'+orgsArray[i].issue_dates+'</span>' : '[processing for future]';

    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var orgDiv = '<div class="twelve columns" style="' +thisStyle+ '">';
  	  orgDiv += '<p class="six columns">';
	    //orgDiv += orgDisplayName +' '+ orgsArray[i].org_city+ ', ' +countriesArray[i].country_name;
	    orgDiv += '<span class="statisticsData">' +orgDisplayName+ '</span>';
	    orgDiv += orgsArray[i].org_city+ ', ' +orgCountryName;

  	    // new 2015-10-21
      if (org_home_uri){
  	    orgDiv += '&nbsp<a href="' +org_home_uri+ '" target="_blank">website</a><br/>';
      }

    orgDiv += '</p>';
/*
        //addCommasToNumString lives in statistics.js
	    orgDiv += '<p class="two columns statisticsData">' +addCommasToNumString( orgsArray[i].publications )+ '</p>';
	    orgDiv += '<p class="two columns statisticsData">' +addCommasToNumString( orgsArray[i].issues )+ '</p>';
	    orgDiv += '<p class="two columns">' +orgIssueDates+ '</p>';
*/

	    orgDiv += '<p class="two columns statisticsData">' + href_to_pubs_by_org;
	      orgDiv += addCommasToNumString( orgsArray[i].publications )+ '</a></p>'; //addCommasToNumString lives in statistics.js
	    orgDiv += '<p class="two columns statisticsData">' + href_to_pubs_by_org;
	      orgDiv += addCommasToNumString( orgsArray[i].issues )+ '</a></p>';
	    orgDiv += '<p class="two columns">' +orgIssueDates+ '</p>';

    orgDiv += '</div>';
    strDebug += '\n' + i+ ') ' +orgDiv;
    //$('#content_wrapper').append('prepareOrgs.', i, '.'); //debugging
	  $('#orgs_report_content').append($( orgDiv ));
	}//end for


  // 2015-10-22 :
  if( b_is_display_page ){
    //console.log('prepareOrgs will exit, having appended the div, and not wanting to call Google maps API on a display page');
    return true;
  }


  var reposCount = orgsArray.length;
  $("#orgsCountValue").html(reposCount);
  $("#orgs_count_trigger").css("list-style-image", "url('')"); //loading image

  //NOTE: actually showing the report is left to the trigger link's click function
  //NOTE: not anymore as of 2014-08-29: here it is:
  // google_visualization_chart( chartTitle, stringColumn, numericColumn, arrayName, chartType )
  google_visualization_chart('Publications by Organization', 'Organization', 'Publications', 'orgsArray', 'pie', 'statistics_chart_canvas_orgs');

  //alert( strDebug );

} //end prepareOrganizations

// helper for display_publications_by_org.php: clicks on Google Chart pie slices return escaped org_name; extract the real one from the url
function get_org_NAME_from_URL( escapedOrgName ){
  var thisURL = window.location.search;
  var org_name = thisURL.substring( thisURL.indexOf("org_name=")+9);
  //console.info('get_org_NAME_from_URL: org_name step 1 = ' +org_name);
  org_name = unescape( org_name );
  //console.info('get_org_NAME_from_URL: org_name final = ' +org_name);
  return org_name;
} // end get_org_NAME_from_URL

function get_org_NAME_from_org_ID( input_org_id ){ // helper for display_publications_by_org.php
  var org_name = input_org_id;
  for (var i = 0; i < orgsArray.length; i++) {
    if (orgsArray[i].org_id == input_org_id) { return orgsArray[i].org_name; }
  }
  return ""; //failure
} // end get_org_NAME_from_org_ID

function get_org_ID_from_org_NAME( input_org_name ){ // helper for display_publications_by_org.php
  var org_id = '@@@';
  //console.info('get_org_ID_from_org_NAME: search ' +input_org_name);
  for (var i = 0; i < orgsArray.length; i++) {
    //if ( i % 150 == 0) console.info(i+ ') get_org_ID_from_org_NAME: found: ' +orgsArray[i].org_name+ ' with id = ', orgsArray[i].org_id);
    //if ( orgsArray[i].org_name.indexOf('University') != -1) console.info(i+ ') get_org_ID_from_org_NAME: found: ' +orgsArray[i].org_name+ ' with id = ', orgsArray[i].org_id);
    if (orgsArray[i].org_name == input_org_name) {
      //console.info('get_org_ID_from_org_NAME: org_id FINAL = ' +orgsArray[i].org_id);
      return orgsArray[i].org_id;
    }// end if
  }// end for
  return '@@@'; //failure
} // end get_org_ID_from_org_NAME

/******************************************************************************************/



/******************************************************************************************/
var formatsArray = Array(); // made useable in prepareFormats: declared here so also visible to Google Charts API

function prepareFormats(formatsJSON){ // see get_countries.php by CJ
  var strDebug = "prepareFormats(\n\tformatsJSON\n)";
  formatsArray = JSON.parse(formatsJSON);
  for (var i = 0; i < formatsArray.length; i++) {
    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var formatDiv = '<div class="twelve columns" style="' +thisStyle+ '">';
    formatDiv += '<p class="six columns"><!--' + formatsArray[i].format_id+ '-->';
      formatDiv += '<span class="statisticsData">' +formatsArray[i].format_name.replace("\\/", "/");+ '</span>&nbsp;';
      /*formatDiv += '<a class="statistics_info_link" ';
        formatDiv += 'id="explainFormat'+formatsArray[i].format_id+'">[explain]</a>'; */
      //formatDiv += formatsArray[i].format_note.replace("\\/", "/");
    formatDiv += '</p>';
      //addCommasToNumString lives in statistics.js
    formatDiv += '<p class="three columns statisticsData">' +addCommasToNumString( formatsArray[i].publications )+ '</p>';
    formatDiv += '<p class="three columns statisticsData">' +addCommasToNumString( formatsArray[i].issues )+ '</p>';
    formatDiv += '</div>';

    strDebug += "\n"+i+") " +formatDiv;
    $('#formats_report_content').append($( formatDiv ));
/*
    var thisFormatNote = formatsArray[i].format_note.replace("\\/", "/");
    $('#explainFormat' +formatsArray[i].format_id ).click(function() {
      alert( thisFormatNote );
    });
*/


  } //end for


  // 2015-10-22 :
  if( b_is_display_page ){
    //console.log('prepareFormats will exit, having appended the div, and not wanting to call Google maps API on a display page');
    return true;
  }

  var formatsCount = formatsArray.length;
  $("#formatsCountValue").text(formatsCount);

  $("#formats_count_trigger").css("list-style-image", "url('')"); //loading image

  //NOTE: actually showing the report is left to the trigger link's click function
  //NOTE: not anymore as of 2014-08-29: here it is:
  // google_visualization_chart( chartTitle, stringColumn, numericColumn, arrayName, chartType )
  google_visualization_chart('Issues by Format', 'Formats', 'Issues', 'formatsArray', 'pie', 'statistics_chart_canvas_formats');

  //alert("finishing formatsArray.length[" +formatsArray.length+ "] formats\n" +strDebug);

} //end prepareFormats

/******************************************************************************************/



/******************************************************************************************/
var yearsArray = Array(); // yearsArray is made useable in prepareYears: declared here so also visible to Google Charts API

function prepareYears(yearsJSON){
  var strDebug = "prepareyears(\n\tyearsJSON\n)";
  //alert(strDebug +"\n\n"+ yearsJSON.toString());
  yearsArray = JSON.parse(yearsJSON);
  for (var i = 0; i < yearsArray.length; i++) {
    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var yearDiv = '<div class="twelve columns" style="' +thisStyle+ '">';
    yearDiv += '<p class="six columns statisticsData">' +yearsArray[i].this_year+ '</p>';
      // addCommasToNumString lives in statistics.js
    yearDiv += '<p class="three columns statisticsData">' +addCommasToNumString( yearsArray[i].year_pubs )+ '</p>';
    yearDiv += '<p class="three columns statisticsData">' +addCommasToNumString( yearsArray[i].year_issues )+ '</p>';
    yearDiv += '</div>';

    strDebug += "\n"+i+") " +yearDiv;
    $('#years_report_content').append($( yearDiv ));
  } //end for


  // 2015-10-22 :
  if( b_is_display_page ){
    //console.log('prepareYears will exit, having appended the div, and not wanting to call Google maps API on a display page');
    return true;
  }

  $("#years_count_trigger").css("list-style-image", "url('')"); //loading image

  //NOTE: actually showing the report is left to the trigger link's click function
  //NOTE: not anymore as of 2014-08-29: here it is:
  // google_visualization_chart( chartTitle, stringColumn, numericColumn, arrayName, chartType )
  google_visualization_chart('Publications by Year', 'Years', 'Publications', 'yearsArray', 'line', 'statistics_chart_canvas_years');

  //alert(strDebug);

} //end prepareYears
/******************************************************************************************/



/******************************************************************************************/
var languagesArray = Array(); // made useable in prepareLanguages: declared here so also visible to Google Charts API

function prepareLanguages(languagesJSON){ // see get_statistics_languages.php
  var strDebug = "prepareLanguages(\n\tlanguagesJSON\n)";
  //console.log('prepareLanguages: languagesJSON = ', languagesJSON);
  languagesArray = JSON.parse(languagesJSON);
  for (var i = 0; i < languagesArray.length; i++) {

    var lang_name   = languagesArray[i].language_name;
    var lang_id     = languagesArray[i].language_id;

    //languagesArray[i].issue_dates may be null; add a note if it is
    var languageIssueDates = (languagesArray[i].issue_dates) ? '<span class="statisticsData">'+languagesArray[i].issue_dates+'</span>' : '[processing for future]';

    var lang_href = '<a href="display_publications_by_language.php?language_name=' +lang_name+ '" ';
      lang_href += 'tooltip="see all publications in "' +lang_name+ '" class="statisticsData">';
    var thisStyle = (i%2 == 0) ? "background-color:#ffffff;" : "background-color:#cccccc;";
    var languageDiv = '<div class="twelve columns" style="' +thisStyle+ '">';
      languageDiv += '<p class="six columns"><!--' + lang_id+ '-->';
      languageDiv += lang_href + lang_name +'</a></p>';
      languageDiv += '<p class="two columns statisticsData">'+ lang_href + addCommasToNumString( languagesArray[i].language_pubs ) + '</a></p>'; //addCommasToNumString lives in statistics.js
      languageDiv += '<p class="two columns statisticsData">'+ lang_href + addCommasToNumString( languagesArray[i].language_issues ) + '</a></p>';
      languageDiv += '<p class="two columns">' +languageIssueDates+ '</p>';
      languageDiv += '</div>';

    strDebug += "\n"+i+") " +languageDiv;
    $('#languages_report_content').append($( languageDiv ));

  } //end for


  // 2015-10-22 :
  if( b_is_display_page ){
    //console.log('prepareLanguages will exit, having appended the div, and not wanting to call Google maps API on a display page');
    return true;
  }

  var languagesCount = languagesArray.length;
  $("#languagesCountValue").text(languagesCount);

  $("#languages_count_trigger").css("list-style-image", "url('')"); //loading image

  //console.log("finishing languagesArray.length[" +languagesArray.length+ "] languages");

  //NOTE: actually showing the report is left to the trigger link's click function
  //NOTE: not anymore as of 2014-08-29: here it is:
  // google_visualization_chart( chartTitle, stringColumn, numericColumn, arrayName, chartType )
  google_visualization_chart( 'Percent of publications by language', 'Language', 'Publications', 'languagesArray', 'pie', 'statistics_chart_canvas_languages');


} //end prepareLanguages
/******************************************************************************************/






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


/***************************************************************************
functions progress and start_progress: a small loading bar 2015-10-26
*/
function progress(percent, page_element, bar_text) {
    // after: http://workshop.rs/2012/12/animated-progress-bar-in-4-lines-of-jquery/
    // also see icon.css

    var target_div = $('body').find(page_element);

    //console.warn('progress starts with target_div.width = ', target_div.width()); // begins at full width every time

    var progressBarWidth = (percent * target_div.width()) / 100;
    if ((percent == 0) || (percent == 100)) progressBarWidth = 0;

    progressBarWidth = Math.round( progressBarWidth );

    var strDebug = 'progress('+ percent +', '+ page_element +', '+ bar_text +') ; ';
      strDebug += 'target_div.width() = '+ target_div.width()  +' ; ';
      strDebug += ' will set to progressBarWidth = '+ progressBarWidth;

    /*
      $('#progressBar').find('div').animate({ width: progressBarWidth }, 500).html(percent + "% some text");
      $('#progressBar').animate({ width: progressBarWidth }, 1).html(percent +"% "+ bar_text);

    AJE modified so not using a div inside another ;
        - effect is that it clears the existing div, if percent is getting lower on each call (countdown)
        - or that it goes from nothing to growing, if percent increasing
        - if div inside div, parent is always on page but little div counts down or grows inside it

    */

    if (percent != 100){
      //console.info(strDebug);
      target_div.animate({ width: progressBarWidth }, 1).html(percent +"% "+ bar_text);
    } else {
      //console.warn('progress(): page_element = ', page_element, ' end with progressBarWidth = ', progressBarWidth, ' ; test yes animate()');
      //target_div.animate({ width: 0 }, 500).html("");
      target_div.animate({ width: 0 }, 1).html("");
    }
}// end function progress
function start_progress( num_iterations ){

    var bar_percent = 0;
    for( var p = 0; p < num_iterations; p++){
    if (p != (num_iterations - 1) ){
      bar_percent = (p / num_iterations) * 100;
    } else { bar_percent = 100; }

    bar_percent = Math.round( bar_percent );
    progress( bar_percent, "#pb_report_progressBar", bar_percent +"_whyHello_"+p);

    if (p < 5 || p == (num_iterations-1) || p == num_iterations){ // reduce debugging messages on large sets
    //console.log('start_progress: ', p, ') num_iterations=', num_iterations, ' ; bar_percent = ', bar_percent);
    }
  } // end for P = PROGRESS
}// end start_progress
/****************************************************************************/





$(document).ready(function() {

  //console.warn('statistics.js doc.ready');

  $("#statistics_title").text( thisPageTitle );
  $("#loadedVersionNote").text(loadedVersionText);
  $("#other_version_trigger").html(otherVersionText);

/*
  2014-08-29
  JSON callback functions: prepareOrganizations, prepareYears, prepareFormats now include calls to google_visualization_chart in googleChartsAPIfunctions.js

  2015-10-22 AJE : along with trying to spped up everything else, there's no way we'll ever be doing stats from live, so:
    change the if
    //if( b_is_static_page ){ //load static JSON from the given files
    check filename instead
  */
  if( ! b_is_display_page ){ // then load static JSON from the given files

    //console.warn('statistics.js doc.ready: into the IF for NOT b_is_display_page');
      // display*.php pages can call these functions separately
    $.get("get_statistics_countries_static.php", prepareCountries); //call countries first so organizations can use it
    $.get("get_statistics_organizations_static.php", prepareOrganizations);
    $.get("get_issues_and_publications_counts.php", preparePubsIssuesCounts);
    $.get("get_statistics_years_static.php", prepareYears);
    $.get("get_statistics_formats_static.php", prepareFormats);
    $.get("get_statistics_languages_static.php", prepareLanguages);
  } // end if

    /*
    else { //load live JSON from the database
      $.get("get_issues_and_publications_counts.php", preparePubsIssuesCounts);
      $.get("get_statistics_countries.php", prepareCountries); //call countries first so organizations can use it

      $.get("get_statistics_organizations.php", prepareOrganizations);
      $.get("get_statistics_years.php", prepareYears);
      $.get("get_statistics_formats.php", prepareFormats);
      $.get("get_statistics_languages.php", prepareLanguages);

    } //end if-else */


  // *[country]CountValue vars are used in the statistics display
    // ICON/staticStatistics/pubsCountriesQueries.sql
  $("#pubsUSstateCountValue").text("51"); // publications --> country codes for how many US state jurisdictions represented?
  // 50 states, DCU, XXU ; XXU not separated for the above count

  $("#pubsCanadaProvinceCountValue").text("10"); // publications --> country codes for how many Canadian province jurisdictions represented?
  // pubsCanadaProvinceCountValue was 9 before 2015-09-21

  $("#pubsOtherCountryCountValue").text("170"); // publications --> country codes for how may NOT US states, and NOT Canadian provinces?
  // pubsOtherCountryCountValue wsa 159 before 2015-09-21
    // ICON/staticStatistics/reposCountriesQueries.sql

  $("#orgsUSstateCountValue").text("51"); //contributing organizations --> country codes for how many US state jurisdictions represented?
  // orgsUSstateCountValue still 51

  $("#orgsCanadaProvinceCountValue").text("4"); //contributing organizations --> country codes for how many Canadian province jurisdictions represented?
  //orgsCanadaProvinceCountValue was zero before 2015-09-21

  $("#orgsOtherCountryCountValue").text("6"); //contributing organizations --> country codes for how may NOT US states, and NOT Canadian provinces?
  //orgsOtherCountryCountValue was 1 before 2015-09-21


  //all pages static or live:
  //  SELECT DISTINCT(org_id) FROM issues;
  //  [if add] WHERE issue_date <> '0000-00-00'; //will time out
  $("#orgsCountValue").text("3062");



  $("#minYearValue").text("1649"); //all pages static or live
  $("#maxYearValue").text("2015"); //all pages static or live

});//end doc.ready func